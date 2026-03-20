import 'package:booking_app/features/auth/data/models/user_model.dart';
import 'package:booking_app/features/auth/domain/entities/user_entity.dart';

class UserMapper {
  const UserMapper._();

  static UserEntity toEntity(UserModel m) => UserEntity(
    id: m.id,
    email: m.email,
    displayName: m.displayName,
    photoUrl: m.photoUrl,
    phoneNumber: m.phoneNumber,
    dateOfBirth: m.dateOfBirth,
    address: m.address,
    role: UserRoleX.fromString(m.role),
    isEmailVerified: m.isEmailVerified,
    isActive: m.isActive,
    createdAt: m.createdAt,
    updatedAt: m.updatedAt,
    shopName: m.shopName,
    shopAddress: m.shopAddress,
    shopCategory: m.shopCategory,
    sellerStatus: m.sellerStatus, // ← thêm
    rejectedReason: m.rejectedReason, // ← thêm
  );

  static UserModel fromEntity(UserEntity e) => UserModel(
    id: e.id,
    email: e.email,
    displayName: e.displayName,
    photoUrl: e.photoUrl,
    phoneNumber: e.phoneNumber,
    dateOfBirth: e.dateOfBirth,
    address: e.address,
    role: e.role.value,
    isEmailVerified: e.isEmailVerified,
    isActive: e.isActive,
    createdAt: e.createdAt,
    updatedAt: e.updatedAt,
    shopName: e.shopName,
    shopAddress: e.shopAddress,
    shopCategory: e.shopCategory,
    sellerStatus: e.sellerStatus, // ← thêm
    rejectedReason: e.rejectedReason, // ← thêm
  );
}
