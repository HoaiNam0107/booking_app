part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final UserEntity user;
  const AuthAuthenticated({required this.user});
  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthFailureState extends AuthState {
  final String message;
  const AuthFailureState({required this.message});
  @override
  List<Object?> get props => [message];
}

class AuthPasswordResetSent extends AuthState {
  const AuthPasswordResetSent();
}

/// Seller vừa đăng ký — chờ admin duyệt
class AuthSellerPendingApproval extends AuthState {
  final UserEntity user;
  const AuthSellerPendingApproval({required this.user});
  @override
  List<Object?> get props => [user];
}

/// Seller đăng nhập nhưng bị từ chối — hiện thông báo lý do
class AuthSellerRejected extends AuthState {
  final String message;
  const AuthSellerRejected({required this.message});
  @override
  List<Object?> get props => [message];
}
