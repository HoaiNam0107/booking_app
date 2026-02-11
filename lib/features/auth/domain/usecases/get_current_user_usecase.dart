import 'package:injectable/injectable.dart';

import '../entities/auth_user_entity.dart';
import '../repositories/auth_repository.dart';
@injectable
class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<AuthUserEntity?> call() {
    return repository.getCurrentUser();
  }
}
