// lib/features/auth/presentation/bloc/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/base_bloc.dart';
import '../../../../core/bloc/base_state.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  AuthBloc(
    this._loginUseCase,
    this._signUpUseCase,
    this._getCurrentUserUseCase,
    this._logoutUseCase,
  ) : super(const AuthState()) {
    on<AuthLogin>(_onLogin);
    on<AuthSignUp>(_onSignUp);
    on<AuthCheckCurrentUser>(_onCheckCurrentUser);
    on<AuthLogout>(_onLogout);
  }

  final LoginUseCase _loginUseCase;
  final SignUpUseCase _signUpUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final LogoutUseCase _logoutUseCase;

  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: const BaseState.loading()));

    try {
      final user = await _loginUseCase(email: event.email, password: event.password);
      emit(state.copyWith(status: BaseState.success(user)));
    } catch (e) {
      emit(state.copyWith(status: const BaseState.failure('Login failed')));
    }
  }

  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: const BaseState.loading()));

    try {
      final user = await _signUpUseCase(
        email: event.email,
        password: event.password,
        name: event.name,
      );

      emit(state.copyWith(status: BaseState.success(user)));
    } catch (e) {
      emit(state.copyWith(status: const BaseState.failure('Sign up failed')));
    }
  }

  Future<void> _onCheckCurrentUser(AuthCheckCurrentUser event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: const BaseState.loading()));

    final user = await _getCurrentUserUseCase();
    emit(state.copyWith(status: BaseState.success(user)));
  }

  Future<void> _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: const BaseState.loading()));
    await _logoutUseCase();
    emit(state.copyWith(status: const BaseState.success(null)));
  }
}
