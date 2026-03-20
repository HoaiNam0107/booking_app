import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/utils/either.dart';
import 'package:booking_app/features/admin/data/datasources/admin_remote_datasource.dart';
import 'package:booking_app/features/admin/domain/entities/seller_request_entity.dart';
import 'package:booking_app/features/admin/domain/repositories/admin_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AdminRepository)
class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource _remote;
  AdminRepositoryImpl(this._remote);

  // ── Watch Sellers ─────────────────────────────────────────────────────────

  @override
  Stream<Either<Failure, List<SellerRequestEntity>>> watchSellerRequests(SellerStatus status) {
    return _remote
        .watchSellersByStatus(status.value)
        .map<Either<Failure, List<SellerRequestEntity>>>((list) {
          final entities = list.map(_toEntity).toList();
          return Right(entities);
        })
        .handleError((e) {
          return Left<Failure, List<SellerRequestEntity>>(ServerFailure(message: e.toString()));
        });
  }

  // ── Approve ───────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, void>> approveSeller(String userId) async {
    try {
      await _remote.approveSeller(userId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  // ── Reject ────────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, void>> rejectSeller(String userId, String reason) async {
    try {
      await _remote.rejectSeller(userId, reason);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  // ── Create Shipper ────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, void>> createShipper({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
    required String dateOfBirth,
    required String vehicleType,
    required String licensePlate,
  }) async {
    try {
      await _remote.createShipperAccount(
        email: email,
        password: password,
        displayName: displayName,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        vehicleType: vehicleType,
        licensePlate: licensePlate,
      );
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  // ── Watch Shippers ────────────────────────────────────────────────────────

  @override
  Stream<Either<Failure, List<Map<String, dynamic>>>> watchShippers() {
    return _remote
        .watchShippers()
        .map<Either<Failure, List<Map<String, dynamic>>>>((list) => Right(list))
        .handleError((e) {
          return Left<Failure, List<Map<String, dynamic>>>(ServerFailure(message: e.toString()));
        });
  }

  // ── Mapper ────────────────────────────────────────────────────────────────

  SellerRequestEntity _toEntity(Map<String, dynamic> d) {
    return SellerRequestEntity(
      id: d['id'] as String,
      email: d['email'] as String,
      displayName: d['displayName'] as String? ?? '',
      phoneNumber: d['phoneNumber'] as String? ?? '',
      dateOfBirth: d['dateOfBirth'] as String?,
      address: d['address'] as String?,
      shopName: d['shopName'] as String? ?? '',
      shopAddress: d['shopAddress'] as String? ?? '',
      shopCategory: d['shopCategory'] as String? ?? '',
      status: SellerStatusX.fromString(d['sellerStatus'] as String? ?? 'pending'),
      createdAt: (d['createdAt'] as Timestamp).toDate(),
      updatedAt: (d['updatedAt'] as Timestamp).toDate(),
      rejectedReason: d['rejectedReason'] as String?,
    );
  }
}
