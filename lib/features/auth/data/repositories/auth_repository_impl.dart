import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enum/user_role.dart';
import '../../domain/entities/auth_user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_firestore_data_source.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_user_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;
  final AuthFirestoreDataSource firestore;

  AuthRepositoryImpl({required this.remote, required this.local, required this.firestore});

  @override
  Future<AuthUserEntity> login({required String email, required String password}) async {
    await remote.login(email: email, password: password);

    final firebaseUser = remote.getCurrentFirebaseUser();
    if (firebaseUser == null) {
      throw Exception('User not found');
    }

    final userModel = await firestore.getUser(firebaseUser.uid);
    if (userModel == null) {
      throw Exception('User data not found');
    }

    final token = await firebaseUser.getIdToken(true);
    await local.saveRefreshToken(token!);

    return userModel.toEntity();
  }

  @override
  Future<AuthUserEntity> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) async {
    final userModel = await remote.signUp(email: email, password: password, name: name, role: role);

    await firestore.saveUser(userModel);

    final token = await FirebaseAuth.instance.currentUser?.getIdToken(true);
    if (token != null) {
      await local.saveRefreshToken(token);
    }

    return userModel.toEntity();
  }

  @override
  Future<void> forgotPassword(String email) {
    return remote.forgotPassword(email);
  }

  @override
  Future<void> logout() async {
    await remote.logout();
    await local.clear();
  }

  @override
  Future<AuthUserEntity?> getCurrentUser() async {
    final firebaseUser = remote.getCurrentFirebaseUser();
    if (firebaseUser == null) return null;

    final userModel = await firestore.getUser(firebaseUser.uid);
    return userModel?.toEntity();
  }
}
