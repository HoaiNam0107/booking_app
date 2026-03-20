import 'package:equatable/equatable.dart';

enum SellerStatus { pending, approved, rejected }

extension SellerStatusX on SellerStatus {
  String get label => switch (this) {
    SellerStatus.pending => 'Chờ duyệt',
    SellerStatus.approved => 'Đã duyệt',
    SellerStatus.rejected => 'Từ chối',
  };

  String get value => switch (this) {
    SellerStatus.pending => 'pending',
    SellerStatus.approved => 'approved',
    SellerStatus.rejected => 'rejected',
  };

  static SellerStatus fromString(String v) => switch (v) {
    'approved' => SellerStatus.approved,
    'rejected' => SellerStatus.rejected,
    _ => SellerStatus.pending,
  };
}

class SellerRequestEntity extends Equatable {
  final String id;
  final String email;
  final String displayName;
  final String phoneNumber;
  final String? dateOfBirth;
  final String? address;
  final String shopName;
  final String shopAddress;
  final String shopCategory;
  final SellerStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? rejectedReason;

  const SellerRequestEntity({
    required this.id,
    required this.email,
    required this.displayName,
    required this.phoneNumber,
    this.dateOfBirth,
    this.address,
    required this.shopName,
    required this.shopAddress,
    required this.shopCategory,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.rejectedReason,
  });

  @override
  List<Object?> get props => [id, status, updatedAt];
}
