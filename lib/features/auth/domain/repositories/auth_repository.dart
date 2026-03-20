import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/utils/either.dart';
import 'package:booking_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  /// Đăng nhập email/password
  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  /// Đăng ký khách hàng
  Future<Either<Failure, UserEntity>> registerCustomer({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
    required String dateOfBirth,
    required String address,
  });

  /// Đăng ký người bán
  Future<Either<Failure, UserEntity>> registerSeller({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
    required String dateOfBirth,
    required String address,
    required String shopName,
    required String shopAddress,
    required String shopCategory,
  });

  /// Đăng xuất
  Future<Either<Failure, void>> logout();

  /// Lấy user hiện tại (từ local cache)
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  /// Stream realtime trạng thái auth
  Stream<UserEntity?> get authStateChanges;

  /// Gửi email đặt lại mật khẩu
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);

  /// Xoá session local
  Future<Either<Failure, void>> clearLocalSession();
}
