import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/auth_user_model.dart';

abstract class AuthFirestoreDataSource {
  Future<void> saveUser(AuthUserModel user);
  Future<AuthUserModel?> getUser(String uid);
}

@LazySingleton(as: AuthFirestoreDataSource)
class AuthFirestoreDataSourceImpl implements AuthFirestoreDataSource {
  final FirebaseFirestore _firestore;

  AuthFirestoreDataSourceImpl(this._firestore);

  @override
  Future<void> saveUser(AuthUserModel user) {
    return _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'name': user.name,
      'createdAt': FieldValue.serverTimestamp(),
      'role': 'user',
    });
  }

  @override
  Future<AuthUserModel?> getUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return AuthUserModel.fromJson(doc.data()!);
  }
}
