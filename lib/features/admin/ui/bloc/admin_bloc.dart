import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:booking_app/features/admin/domain/entities/seller_request_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../domain/usecase/admin_usecases.dart';

part 'admin_event.dart';
part 'admin_state.dart';

@injectable
class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final WatchSellerRequestsUseCase _watchSellers;
  final ApproveSellerUseCase _approveSeller;
  final RejectSellerUseCase _rejectSeller;
  final CreateShipperUseCase _createShipper;
  final WatchShippersUseCase _watchShippers;
  final Talker _talker;

  StreamSubscription? _pendingSub;
  StreamSubscription? _approvedSub;
  StreamSubscription? _rejectedSub;
  StreamSubscription? _shippersSub;

  AdminBloc(
    this._watchSellers,
    this._approveSeller,
    this._rejectSeller,
    this._createShipper,
    this._watchShippers,
    this._talker,
  ) : super(const AdminState()) {
    on<AdminWatchSellersStarted>(_onWatchSellers);
    on<_SellersUpdated>(_onSellersUpdated);
    on<AdminApproveSeller>(_onApprove);
    on<AdminRejectSeller>(_onReject);
    on<AdminWatchShippersStarted>(_onWatchShippers);
    on<_ShippersUpdated>(_onShippersUpdated);
    on<AdminCreateShipper>(_onCreateShipper);
    on<_AdminErrorOccurred>(_onError);
  }

  // ── Watch Sellers ─────────────────────────────────────────────────────────

  void _onWatchSellers(AdminWatchSellersStarted event, Emitter<AdminState> emit) {
    emit(state.copyWith(sellersLoading: true));

    _pendingSub?.cancel();
    _approvedSub?.cancel();
    _rejectedSub?.cancel();

    _pendingSub = _watchSellers(SellerStatus.pending).listen(
      (result) => result.fold(
        (f) => add(_AdminErrorOccurred(f.message)),
        (list) => add(_SellersUpdated(SellerStatus.pending, list)),
      ),
    );

    _approvedSub = _watchSellers(SellerStatus.approved).listen(
      (result) => result.fold((_) {}, (list) => add(_SellersUpdated(SellerStatus.approved, list))),
    );

    _rejectedSub = _watchSellers(SellerStatus.rejected).listen(
      (result) => result.fold((_) {}, (list) => add(_SellersUpdated(SellerStatus.rejected, list))),
    );
  }

  void _onSellersUpdated(_SellersUpdated event, Emitter<AdminState> emit) {
    switch (event.status) {
      case SellerStatus.pending:
        emit(state.copyWith(pendingSellers: event.sellers, sellersLoading: false));
      case SellerStatus.approved:
        emit(state.copyWith(approvedSellers: event.sellers, sellersLoading: false));
      case SellerStatus.rejected:
        emit(state.copyWith(rejectedSellers: event.sellers, sellersLoading: false));
    }
  }

  // ── Approve ───────────────────────────────────────────────────────────────

  Future<void> _onApprove(AdminApproveSeller event, Emitter<AdminState> emit) async {
    final result = await _approveSeller(event.userId);
    result.fold(
      (f) {
        _talker.error('[AdminBloc] approve failed: ${f.message}');
        emit(state.copyWith(errorMessage: f.message, clearSuccess: true));
      },
      (_) {
        _talker.info('[AdminBloc] approved: ${event.userId}');
        // ✅ Emit successMessage — UI hiện snackbar
        // List tự refresh vì stream Firestore realtime đang watch
        emit(
          state.copyWith(successMessage: 'Đã phê duyệt cửa hàng thành công! 🎉', clearError: true),
        );
      },
    );
  }

  // ── Reject ────────────────────────────────────────────────────────────────

  Future<void> _onReject(AdminRejectSeller event, Emitter<AdminState> emit) async {
    final result = await _rejectSeller(
      RejectSellerParams(userId: event.userId, reason: event.reason),
    );
    result.fold(
      (f) {
        _talker.error('[AdminBloc] reject failed: ${f.message}');
        emit(state.copyWith(errorMessage: f.message, clearSuccess: true));
      },
      (_) {
        _talker.info('[AdminBloc] rejected: ${event.userId}');
        // ✅ Emit successMessage
        emit(state.copyWith(successMessage: 'Đã từ chối cửa hàng.', clearError: true));
      },
    );
  }

  // ── Watch Shippers ────────────────────────────────────────────────────────

  void _onWatchShippers(AdminWatchShippersStarted event, Emitter<AdminState> emit) {
    emit(state.copyWith(shippersLoading: true));
    _shippersSub?.cancel();
    _shippersSub = _watchShippers().listen(
      (result) => result.fold(
        (f) => add(_AdminErrorOccurred(f.message)),
        (list) => add(_ShippersUpdated(list)),
      ),
    );
  }

  void _onShippersUpdated(_ShippersUpdated event, Emitter<AdminState> emit) {
    emit(state.copyWith(shippers: event.shippers, shippersLoading: false));
  }

  // ── Create Shipper ────────────────────────────────────────────────────────

  Future<void> _onCreateShipper(AdminCreateShipper event, Emitter<AdminState> emit) async {
    emit(
      state.copyWith(
        createShipperLoading: true,
        createShipperSuccess: false,
        clearError: true,
        clearSuccess: true,
      ),
    );

    final result = await _createShipper(
      CreateShipperParams(
        email: event.email,
        password: event.password,
        displayName: event.displayName,
        phoneNumber: event.phoneNumber,
        dateOfBirth: event.dateOfBirth,
        vehicleType: event.vehicleType,
        licensePlate: event.licensePlate,
      ),
    );

    result.fold(
      (f) {
        _talker.error('[AdminBloc] createShipper failed: ${f.message}');
        emit(state.copyWith(createShipperLoading: false, errorMessage: f.message));
      },
      (_) {
        _talker.info('[AdminBloc] shipper created: ${event.email}');
        emit(
          state.copyWith(
            createShipperLoading: false,
            createShipperSuccess: true,
            successMessage: 'Tạo tài khoản shipper thành công!',
            clearError: true,
          ),
        );
      },
    );
  }

  void _onError(_AdminErrorOccurred event, Emitter<AdminState> emit) {
    _talker.error('[AdminBloc] error: ${event.message}');
    emit(
      state.copyWith(errorMessage: event.message, sellersLoading: false, shippersLoading: false),
    );
  }

  @override
  Future<void> close() {
    _pendingSub?.cancel();
    _approvedSub?.cancel();
    _rejectedSub?.cancel();
    _shippersSub?.cancel();
    return super.close();
  }
}
