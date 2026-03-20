import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/utils/either.dart';
import 'package:booking_app/features/admin/domain/entities/seller_request_entity.dart';

abstract class AdminRepository {
  /// Stream realtime danh sách seller theo status
  Stream<Either<Failure, List<SellerRequestEntity>>> watchSellerRequests(SellerStatus status);

  /// Phê duyệt seller → isActive = true, sellerStatus = 'approved'
  Future<Either<Failure, void>> approveSeller(String userId);

  /// Từ chối seller → isActive = false, sellerStatus = 'rejected'
  Future<Either<Failure, void>> rejectSeller(String userId, String reason);

  /// Tạo tài khoản shipper: Firebase Auth + Firestore role = 'shipper'
  Future<Either<Failure, void>> createShipper({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
    required String dateOfBirth,
    required String vehicleType,
    required String licensePlate,
  });

  /// Stream realtime danh sách shipper
  Stream<Either<Failure, List<Map<String, dynamic>>>> watchShippers();
}
