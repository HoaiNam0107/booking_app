import 'package:bloc/bloc.dart';
import 'package:booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:booking_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:booking_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:booking_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:booking_app/features/auth/domain/usecases/register_customer_usecase.dart';
import 'package:booking_app/features/auth/domain/usecases/register_seller_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../core/error/failures.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _login;
  final RegisterCustomerUseCase _registerCustomer;
  final RegisterSellerUseCase _registerSeller;
  final LogoutUseCase _logout;
  final GetCurrentUserUseCase _getCurrentUser;
  final Talker _talker;

  AuthBloc(
      this._login,
      this._registerCustomer,
      this._registerSeller,
      this._logout,
      this._getCurrentUser,
      this._talker,
      ) : super(const AuthInitial()) {
    on<AuthCheckStatusRequested>(_onCheckStatus);
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterCustomerRequested>(_onRegisterCustomer);
    on<AuthRegisterSellerRequested>(_onRegisterSeller);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthPasswordResetRequested>(_onPasswordReset);
  }

  Future<void> _onCheckStatus(
      AuthCheckStatusRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(const AuthLoading());
    final result = await _getCurrentUser();
    result.fold(
          (_) => emit(const AuthUnauthenticated()),
          (user) {
        if (user == null) {
          emit(const AuthUnauthenticated());
          return;
        }
        // Seller pending → hiện màn chờ duyệt
        if (user.isSellerPending) {
          emit(AuthSellerPendingApproval(user: user));
          return;
        }
        emit(AuthAuthenticated(user: user));
      },
    );
  }

  Future<void> _onLogin(
      AuthLoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(const AuthLoading());
    final result = await _login(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
          (f) {
        if (f is AuthFailure && f.statusCode == 403) {
          emit(AuthSellerRejected(message: f.message));
        } else {
          emit(AuthFailureState(message: f.message));
        }
      },
          (user) {
        if (user.isSellerPending) {
          emit(AuthSellerPendingApproval(user: user));
          return;
        }
        emit(AuthAuthenticated(user: user));
      },
    );
  }

  Future<void> _onRegisterCustomer(
      AuthRegisterCustomerRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(const AuthLoading());
    final result = await _registerCustomer(
      RegisterCustomerParams(
        email: event.email,
        password: event.password,
        displayName: event.displayName,
        phoneNumber: event.phoneNumber,
        dateOfBirth: event.dateOfBirth,
        address: event.address,
      ),
    );
    result.fold(
          (f) => emit(AuthFailureState(message: f.message)),
          (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _onRegisterSeller(
      AuthRegisterSellerRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(const AuthLoading());
    final result = await _registerSeller(
      RegisterSellerParams(
        email: event.email,
        password: event.password,
        displayName: event.displayName,
        phoneNumber: event.phoneNumber,
        dateOfBirth: event.dateOfBirth,
        address: event.address,
        shopName: event.shopName,
        shopAddress: event.shopAddress,
        shopCategory: event.shopCategory,
      ),
    );
    result.fold(
          (f) => emit(AuthFailureState(message: f.message)),
          (user) => emit(AuthSellerPendingApproval(user: user)),
    );
  }

  Future<void> _onLogout(
      AuthLogoutRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(const AuthLoading());
    final result = await _logout();
    result.fold(
          (f) {
        _talker.error('[AuthBloc] Logout failed: ${f.message}');
        emit(AuthFailureState(message: f.message));
      },
          (_) {
        _talker.info('[AuthBloc] Logout success');
        emit(const AuthUnauthenticated());
      },
    );
  }

  Future<void> _onPasswordReset(
      AuthPasswordResetRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(const AuthLoading());
    emit(const AuthPasswordResetSent());
  }
}