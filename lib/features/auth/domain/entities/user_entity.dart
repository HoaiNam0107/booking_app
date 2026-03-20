import 'package:equatable/equatable.dart';

enum UserRole { customer, seller, shipper, admin }

extension UserRoleX on UserRole {
  String get label => switch (this) {
    UserRole.customer => 'Khách hàng',
    UserRole.seller => 'Người bán',
    UserRole.shipper => 'Shipper',
    UserRole.admin => 'Quản trị viên',
  };

  String get value => switch (this) {
    UserRole.customer => 'customer',
    UserRole.seller => 'seller',
    UserRole.shipper => 'shipper',
    UserRole.admin => 'admin',
  };

  static UserRole fromString(String value) => switch (value) {
    'seller' => UserRole.seller,
    'shipper' => UserRole.shipper,
    'admin' => UserRole.admin,
    _ => UserRole.customer,
  };
}

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? address;
  final UserRole role;
  final bool isEmailVerified;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  // Seller fields
  final String? shopName;
  final String? shopAddress;
  final String? shopCategory;
  // ── Seller approval ───────────────────────────────────────────────────────
  final String? sellerStatus; // 'pending' | 'approved' | 'rejected' | null
  final String? rejectedReason;

  const UserEntity({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.dateOfBirth,
    this.address,
    required this.role,
    required this.isEmailVerified,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.shopName,
    this.shopAddress,
    this.shopCategory,
    this.sellerStatus,
    this.rejectedReason,
  });

  /// Seller đang chờ duyệt
  bool get isSellerPending => role == UserRole.seller && sellerStatus == 'pending';

  /// Seller đã được duyệt và hoạt động
  bool get isSellerApproved => role == UserRole.seller && sellerStatus == 'approved' && isActive;

  /// Seller bị từ chối
  bool get isSellerRejected => role == UserRole.seller && sellerStatus == 'rejected';

  @override
  List<Object?> get props => [
    id,
    email,
    displayName,
    photoUrl,
    phoneNumber,
    dateOfBirth,
    address,
    role,
    isEmailVerified,
    isActive,
    createdAt,
    updatedAt,
    shopName,
    shopAddress,
    shopCategory,
    sellerStatus,
    rejectedReason,
  ];
}
