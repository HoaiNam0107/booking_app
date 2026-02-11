import '../entities/auth_user_entity.dart';

abstract class AuthRepository {
  Future<AuthUserEntity> login({required String email, required String password});

  Future<AuthUserEntity> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<void> forgotPassword(String email);

  Future<void> logout();

  Future<AuthUserEntity?> getCurrentUser();
}
