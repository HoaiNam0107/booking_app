import 'package:booking_app/core/contants/app_constants.dart';
import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/features/admin/domain/entities/seller_request_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class AdminRemoteDataSource {
  Stream<List<Map<String, dynamic>>> watchSellersByStatus(String status);
  Future<void> approveSeller(String userId);
  Future<void> rejectSeller(String userId, String reason);
  Future<void> createShipperAccount({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
    required String dateOfBirth,
    required String vehicleType,
    required String licensePlate,
  });
  Stream<List<Map<String, dynamic>>> watchShippers();
}

@LazySingleton(as: AdminRemoteDataSource)
class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final Talker _talker;

  AdminRemoteDataSourceImpl(this._firestore, this._firebaseAuth, this._talker);

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection(AppConstants.usersCollection);

  // ── Watch Sellers ─────────────────────────────────────────────────────────
  // Query bằng sellerStatus — field được set khi register seller
  // Document cũ chưa có field này → cần thêm thủ công hoặc dùng migration

  @override
  Stream<List<Map<String, dynamic>>> watchSellersByStatus(String status) {
    return _users
        .where('role', isEqualTo: 'seller')
        .where('sellerStatus', isEqualTo: status)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs.map((doc) => <String, dynamic>{...doc.data(), 'id': doc.id}).toList(),
        )
        .handleError((e) {
          _talker.error('[Admin] watchSellersByStatus($status) error: $e');
          throw ServerException(message: 'Lỗi tải danh sách cửa hàng: $e');
        });
  }

  // ── Approve ───────────────────────────────────────────────────────────────
  // Khi duyệt: isActive = true + sellerStatus = 'approved'

  @override
  Future<void> approveSeller(String userId) async {
    try {
      await _users.doc(userId).update({
        'isActive': true,
        'sellerStatus': SellerStatus.approved.value,
        'rejectedReason': FieldValue.delete(),
        'updatedAt': Timestamp.now(),
      });
      _talker.info('[Admin] Seller approved: $userId');
    } catch (e) {
      _talker.error('[Admin] approveSeller error: $e');
      throw ServerException(message: 'Lỗi khi phê duyệt: $e');
    }
  }

  // ── Reject ────────────────────────────────────────────────────────────────
  // Khi từ chối: isActive = false + sellerStatus = 'rejected' + lưu lý do

  @override
  Future<void> rejectSeller(String userId, String reason) async {
    try {
      await _users.doc(userId).update({
        'isActive': false,
        'sellerStatus': SellerStatus.rejected.value,
        'rejectedReason': reason,
        'updatedAt': Timestamp.now(),
      });
      _talker.info('[Admin] Seller rejected: $userId');
    } catch (e) {
      _talker.error('[Admin] rejectSeller error: $e');
      throw ServerException(message: 'Lỗi khi từ chối: $e');
    }
  }

  // ── Create Shipper ────────────────────────────────────────────────────────

  @override
  Future<void> createShipperAccount({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
    required String dateOfBirth,
    required String vehicleType,
    required String licensePlate,
  }) async {
    User? user;
    try {
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = cred.user!;
      await user.updateDisplayName(displayName);
      final now = Timestamp.now();
      await _users.doc(user.uid).set({
        'email': email,
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'role': 'shipper',
        'isEmailVerified': false,
        'isActive': true,
        'vehicleType': vehicleType,
        'licensePlate': licensePlate,
        'totalTrips': 0,
        'rating': 5.0,
        'createdAt': now,
        'updatedAt': now,
      });
      _talker.info('[Admin] Shipper created: ${user.uid}');
    } on FirebaseAuthException catch (e) {
      await user?.delete();
      throw AuthException(message: _mapAuthError(e));
    } catch (e) {
      await user?.delete();
      throw ServerException(message: 'Lỗi tạo shipper: $e');
    }
  }

  // ── Watch Shippers ────────────────────────────────────────────────────────

  @override
  Stream<List<Map<String, dynamic>>> watchShippers() {
    return _users
        .where('role', isEqualTo: 'shipper')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs.map((doc) => <String, dynamic>{...doc.data(), 'id': doc.id}).toList(),
        )
        .handleError((e) {
          _talker.error('[Admin] watchShippers error: $e');
          throw ServerException(message: 'Lỗi tải danh sách shipper: $e');
        });
  }

  String _mapAuthError(FirebaseAuthException e) => switch (e.code) {
    'email-already-in-use' => 'Email đã được sử dụng.',
    'invalid-email' => 'Email không hợp lệ.',
    'weak-password' => 'Mật khẩu quá yếu.',
    _ => e.message ?? 'Lỗi không xác định.',
  };
}
