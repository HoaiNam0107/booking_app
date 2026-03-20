import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? address;
  final String role;
  final bool isEmailVerified;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  // Seller fields
  final String? shopName;
  final String? shopAddress;
  final String? shopCategory;
  // ── Seller approval state ─────────────────────────────────────────────────
  // null       = không phải seller
  // 'pending'  = chờ admin duyệt  → isActive = false
  // 'approved' = đã duyệt         → isActive = true
  // 'rejected' = bị từ chối       → isActive = false
  final String? sellerStatus;
  final String? rejectedReason;

  const UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.dateOfBirth,
    this.address,
    this.role = 'customer',
    this.isEmailVerified = false,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.shopName,
    this.shopAddress,
    this.shopCategory,
    this.sellerStatus,
    this.rejectedReason,
  });

  // ── Firestore ─────────────────────────────────────────────────────────────

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return UserModel(
      id: doc.id,
      email: d['email'] as String,
      displayName: d['displayName'] as String?,
      photoUrl: d['photoUrl'] as String?,
      phoneNumber: d['phoneNumber'] as String?,
      dateOfBirth: d['dateOfBirth'] as String?,
      address: d['address'] as String?,
      role: d['role'] as String? ?? 'customer',
      isEmailVerified: d['isEmailVerified'] as bool? ?? false,
      isActive: d['isActive'] as bool? ?? true,
      createdAt: (d['createdAt'] as Timestamp).toDate(),
      updatedAt: (d['updatedAt'] as Timestamp).toDate(),
      shopName: d['shopName'] as String?,
      shopAddress: d['shopAddress'] as String?,
      shopCategory: d['shopCategory'] as String?,
      sellerStatus: d['sellerStatus'] as String?,
      rejectedReason: d['rejectedReason'] as String?,
    );
  }

  /// toFirestoreMap KHÔNG include sellerStatus / rejectedReason
  /// vì chúng được quản lý riêng bởi admin (không ghi đè khi update profile)
  Map<String, dynamic> toFirestoreMap() => {
    'email': email,
    'displayName': displayName,
    'photoUrl': photoUrl,
    'phoneNumber': phoneNumber,
    'dateOfBirth': dateOfBirth,
    'address': address,
    'role': role,
    'isEmailVerified': isEmailVerified,
    'isActive': isActive,
    'createdAt': Timestamp.fromDate(createdAt),
    'updatedAt': Timestamp.fromDate(updatedAt),
    'shopName': shopName,
    'shopAddress': shopAddress,
    'shopCategory': shopCategory,
  };

  // ── JSON ──────────────────────────────────────────────────────────────────

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    email: json['email'] as String,
    displayName: json['displayName'] as String?,
    photoUrl: json['photoUrl'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    dateOfBirth: json['dateOfBirth'] as String?,
    address: json['address'] as String?,
    role: json['role'] as String? ?? 'customer',
    isEmailVerified: json['isEmailVerified'] as bool? ?? false,
    isActive: json['isActive'] as bool? ?? true,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
    shopName: json['shopName'] as String?,
    shopAddress: json['shopAddress'] as String?,
    shopCategory: json['shopCategory'] as String?,
    sellerStatus: json['sellerStatus'] as String?,
    rejectedReason: json['rejectedReason'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'displayName': displayName,
    'photoUrl': photoUrl,
    'phoneNumber': phoneNumber,
    'dateOfBirth': dateOfBirth,
    'address': address,
    'role': role,
    'isEmailVerified': isEmailVerified,
    'isActive': isActive,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'shopName': shopName,
    'shopAddress': shopAddress,
    'shopCategory': shopCategory,
    'sellerStatus': sellerStatus,
    'rejectedReason': rejectedReason,
  };

  // ── copyWith ──────────────────────────────────────────────────────────────

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
    String? dateOfBirth,
    String? address,
    String? role,
    bool? isEmailVerified,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? shopName,
    String? shopAddress,
    String? shopCategory,
    String? sellerStatus,
    String? rejectedReason,
  }) => UserModel(
    id: id ?? this.id,
    email: email ?? this.email,
    displayName: displayName ?? this.displayName,
    photoUrl: photoUrl ?? this.photoUrl,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    address: address ?? this.address,
    role: role ?? this.role,
    isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    shopName: shopName ?? this.shopName,
    shopAddress: shopAddress ?? this.shopAddress,
    shopCategory: shopCategory ?? this.shopCategory,
    sellerStatus: sellerStatus ?? this.sellerStatus,
    rejectedReason: rejectedReason ?? this.rejectedReason,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          id == other.id &&
          role == other.role &&
          isActive == other.isActive &&
          sellerStatus == other.sellerStatus;

  @override
  int get hashCode => id.hashCode ^ role.hashCode;

  @override
  String toString() =>
      'UserModel(id: $id, role: $role, isActive: $isActive, sellerStatus: $sellerStatus)';
}
