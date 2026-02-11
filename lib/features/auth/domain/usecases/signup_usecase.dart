import 'package:injectable/injectable.dart';

import '../../../../core/enum/user_role.dart';
import '../entities/auth_user_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<AuthUserEntity> call({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) {
    return repository.signUp(email: email, password: password, name: name, role: role);
  }
}
