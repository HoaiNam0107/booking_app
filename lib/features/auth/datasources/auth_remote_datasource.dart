import 'package:booking_app/core/contants/app_constants.dart';
import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel> registerWithEmailPassword({
    required String email,
    required String password,
    required Map<String, dynamic> extraData,
  });

  Future<void> logout();
  Future<UserModel?> fetchCurrentUser(String uid);
  Stream<User?> get authStateChanges;
  Future<void> sendPasswordResetEmail(String email);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final Talker _talker;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._firestore, this._talker);

  CollectionReference<Map<String, dynamic>> get _usersRef =>
      _firestore.collection(AppConstants.usersCollection);

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await fetchCurrentUser(credential.user!.uid);
      if (user == null) {
        throw const ServerException(message: 'Không tìm thấy dữ liệu người dùng.');
      }

      // ── Chặn seller bị từ chối đăng nhập ────────────────────────────────
      if (user.role == 'seller' && user.sellerStatus == 'rejected') {
        throw const AuthException(
          message: 'Tài khoản cửa hàng đã bị từ chối. Vui lòng liên hệ hỗ trợ.',
          statusCode: 403,
        );
      }

      return user;
    } on FirebaseAuthException catch (e) {
      _talker.error('[Auth] Login failed: ${e.code}');
      throw AuthException(message: _mapAuthError(e), statusCode: 401);
    } on ServerException {
      rethrow;
    } on AuthException {
      rethrow;
    } catch (e) {
      _talker.error('[Auth] Login unknown: $e');
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<UserModel> registerWithEmailPassword({
    required String email,
    required String password,
    required Map<String, dynamic> extraData,
  }) async {
    User? firebaseUser;

    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      firebaseUser = credential.user!;

      final displayName = extraData['displayName'] as String? ?? '';
      await firebaseUser.updateDisplayName(displayName);

      final now = DateTime.now();
      final role = extraData['role'] as String? ?? 'customer';
      final isSeller = role == 'seller';

      final model = UserModel(
        id: firebaseUser.uid,
        email: email,
        displayName: displayName,
        phoneNumber: extraData['phoneNumber'] as String?,
        dateOfBirth: extraData['dateOfBirth'] as String?,
        address: extraData['address'] as String?,
        role: role,
        isEmailVerified: firebaseUser.emailVerified,
        isActive: !isSeller, // seller = false (chờ duyệt), customer = true
        createdAt: now,
        updatedAt: now,
        shopName: extraData['shopName'] as String?,
        shopAddress: extraData['shopAddress'] as String?,
        shopCategory: extraData['shopCategory'] as String?,
      );

      final firestoreData = model.toFirestoreMap();

      // ── Thêm sellerStatus chỉ cho seller ─────────────────────────────────
      if (isSeller) {
        firestoreData['sellerStatus'] = 'pending';
      }

      await _usersRef.doc(firebaseUser.uid).set(firestoreData);
      _talker.info('[Auth] Register success: ${firebaseUser.uid} | role: $role');
      return model;
    } on FirebaseAuthException catch (e) {
      _talker.error('[Auth] Register FirebaseAuth failed: ${e.code}');
      throw AuthException(message: _mapAuthError(e), statusCode: 400);
    } catch (e) {
      _talker.error('[Auth] Register failed, rolling back: $e');
      if (firebaseUser != null) {
        try {
          await firebaseUser.delete();
          _talker.info('[Auth] Rollback success: ${firebaseUser.uid}');
        } catch (deleteError) {
          _talker.error('[Auth] Rollback failed: $deleteError');
        }
      }
      throw UnknownException(message: 'Đăng ký thất bại: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      _talker.info('[Auth] Logout success');
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<UserModel?> fetchCurrentUser(String uid) async {
    try {
      final doc = await _usersRef.doc(uid).get();
      if (!doc.exists) return null;
      return UserModel.fromFirestore(doc);
    } catch (e) {
      throw ServerException(message: 'Lỗi khi tải thông tin người dùng: $e');
    }
  }

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: _mapAuthError(e));
    }
  }

  String _mapAuthError(FirebaseAuthException e) => switch (e.code) {
    'user-not-found' => 'Không tìm thấy tài khoản với email này.',
    'wrong-password' => 'Mật khẩu không đúng.',
    'invalid-credential' => 'Email hoặc mật khẩu không đúng.',
    'email-already-in-use' => 'Email này đã được sử dụng.',
    'invalid-email' => 'Định dạng email không hợp lệ.',
    'weak-password' => 'Mật khẩu quá yếu. Vui lòng chọn mật khẩu mạnh hơn.',
    'user-disabled' => 'Tài khoản này đã bị vô hiệu hoá.',
    'too-many-requests' => 'Quá nhiều lần thử. Vui lòng thử lại sau.',
    'network-request-failed' => 'Lỗi mạng. Vui lòng kiểm tra kết nối.',
    _ => e.message ?? 'Lỗi xác thực không xác định.',
  };
}