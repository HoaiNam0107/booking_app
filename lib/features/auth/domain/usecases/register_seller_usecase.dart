import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/utils/either.dart';
import 'package:booking_app/core/utils/usecase.dart';
import 'package:booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:booking_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RegisterSellerUseCase extends UseCase<UserEntity, RegisterSellerParams> {
  final AuthRepository _repository;
  RegisterSellerUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterSellerParams params) =>
      _repository.registerSeller(
        email: params.email,
        password: params.password,
        displayName: params.displayName,
        phoneNumber: params.phoneNumber,
        dateOfBirth: params.dateOfBirth,
        address: params.address,
        shopName: params.shopName,
        shopAddress: params.shopAddress,
        shopCategory: params.shopCategory,
      );
}

class RegisterSellerParams extends Equatable {
  final String email;
  final String password;
  final String displayName;
  final String phoneNumber;
  final String dateOfBirth;
  final String address;
  final String shopName;
  final String shopAddress;
  final String shopCategory;

  const RegisterSellerParams({
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
    email,
    password,
    displayName,
    phoneNumber,
    dateOfBirth,
    address,
    shopName,
    shopAddress,
    shopCategory,
  ];
}
