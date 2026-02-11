import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> login({required String email, required String password});

  Future<AuthUserModel> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<void> forgotPassword(String email);

  Future<void> logout();

  User? getCurrentFirebaseUser();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<AuthUserModel> login({required String email, required String password}) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user!;
    return AuthUserModel(uid: user.uid, email: user.email!, name: user.displayName!);
  }

  @override
  Future<AuthUserModel> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user!;

    await user.updateDisplayName(name);

    return AuthUserModel(uid: user.uid, email: user.email!, name: name);
  }

  @override
  Future<void> forgotPassword(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> logout() {
    return _firebaseAuth.signOut();
  }

  @override
  User? getCurrentFirebaseUser() {
    return _firebaseAuth.currentUser;
  }
}
