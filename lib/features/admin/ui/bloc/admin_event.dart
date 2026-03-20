part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();
  @override
  List<Object?> get props => [];
}

class AdminWatchSellersStarted extends AdminEvent {
  const AdminWatchSellersStarted();
}

class AdminApproveSeller extends AdminEvent {
  final String userId;
  const AdminApproveSeller(this.userId);
  @override
  List<Object?> get props => [userId];
}

class AdminRejectSeller extends AdminEvent {
  final String userId;
  final String reason;
  const AdminRejectSeller({required this.userId, required this.reason});
  @override
  List<Object?> get props => [userId, reason];
}

class AdminWatchShippersStarted extends AdminEvent {
  const AdminWatchShippersStarted();
}

class AdminCreateShipper extends AdminEvent {
  final String email, password, displayName;
  final String phoneNumber, dateOfBirth, vehicleType, licensePlate;
  const AdminCreateShipper({
    required this.email,
    required this.password,
    required this.displayName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.vehicleType,
    required this.licensePlate,
  });
  @override
  List<Object?> get props => [email, displayName];
}

// Internal — chỉ dùng bên trong bloc
class _SellersUpdated extends AdminEvent {
  final SellerStatus status;
  final List<SellerRequestEntity> sellers;
  const _SellersUpdated(this.status, this.sellers);
  @override
  List<Object?> get props => [status, sellers];
}

class _ShippersUpdated extends AdminEvent {
  final List<Map<String, dynamic>> shippers;
  const _ShippersUpdated(this.shippers);
  @override
  List<Object?> get props => [shippers];
}

class _AdminErrorOccurred extends AdminEvent {
  final String message;
  const _AdminErrorOccurred(this.message);
  @override
  List<Object?> get props => [message];
}