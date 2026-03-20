import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/utils/either.dart';
import 'package:booking_app/core/utils/usecase.dart';
import 'package:booking_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUseCase extends UseCaseNoParams<void> {
  final AuthRepository _repository;
  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call() async {
    final logoutResult = await _repository.logout();
    if (logoutResult.isLeft) return logoutResult;

    final clearResult = await _repository.clearLocalSession();
    if (clearResult.isLeft) return clearResult;

    return const Right(null);
  }
}
