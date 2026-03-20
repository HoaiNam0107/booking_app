part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthCheckStatusRequested extends AuthEvent {
  const AuthCheckStatusRequested();
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  const AuthLoginRequested({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterCustomerRequested extends AuthEvent {
  final String email;
  final String password;
  final String displayName;
  final String phoneNumber;
  final String dateOfBirth;
  final String address;

  const AuthRegisterCustomerRequested({
    required this.email,
    required this.password,
    required this.displayName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.address,
  });

  @override
  List<Object?> get props =>
      [email, password, displayName, phoneNumber, dateOfBirth, address];
}

class AuthRegisterSellerRequested extends AuthEvent {
  final String email;
  final String password;
  final String displayName;
  final String phoneNumber;
  final String dateOfBirth;
  final String address;
  final String shopName;
  final String shopAddress;
  final String shopCategory;

  const AuthRegisterSellerRequested({
    required this.email,
    required this.password,
    required this.displayName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.address,
    required this.shopName,
    required this.shopAddress,
    required this.shopCategory,
  });

  @override
  List<Object?> get props => [
    email, password, displayName, phoneNumber,
    dateOfBirth, address, shopName, shopAddress, shopCategory,
  ];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthPasswordResetRequested extends AuthEvent {
  final String email;
  const AuthPasswordResetRequested({required this.email});
  @override
  List<Object?> get props => [email];
}