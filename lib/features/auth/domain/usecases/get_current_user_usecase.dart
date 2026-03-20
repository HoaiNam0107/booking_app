import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/utils/either.dart';
import 'package:booking_app/core/utils/usecase.dart';
import 'package:booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:booking_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCurrentUserUseCase extends UseCaseNoParams<UserEntity?> {
  final AuthRepository _repository;
  GetCurrentUserUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity?>> call() => _repository.getCurrentUser();
}
