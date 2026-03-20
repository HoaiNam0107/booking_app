import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/utils/either.dart';
import 'package:booking_app/core/utils/usecase.dart';
import 'package:booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:booking_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RegisterCustomerUseCase extends UseCase<UserEntity, RegisterCustomerParams> {
  final AuthRepository _repository;
  RegisterCustomerUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterCustomerParams params) =>
      _repository.registerCustomer(
        email: params.email,
        password: params.password,
        displayName: params.displayName,
        phoneNumber: params.phoneNumber,
        dateOfBirth: params.dateOfBirth,
        address: params.address,
      );
}

class RegisterCustomerParams extends Equatable {
  final String email;
  final String password;
  final String displayName;
  final String phoneNumber;
  final String dateOfBirth;
  final String address;

  const RegisterCustomerParams({
    required this.email,
    required this.password,
    required this.displayName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.address,
  });

  @override
  List<Object?> get props => [email, password, displayName, phoneNumber, dateOfBirth, address];
}
