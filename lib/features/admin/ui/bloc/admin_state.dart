part of 'admin_bloc.dart';

class AdminState extends Equatable {
  final List<SellerRequestEntity> pendingSellers;
  final List<SellerRequestEntity> approvedSellers;
  final List<SellerRequestEntity> rejectedSellers;
  final bool sellersLoading;
  final List<Map<String, dynamic>> shippers;
  final bool shippersLoading;
  final bool createShipperLoading;
  final bool createShipperSuccess;
  final String? errorMessage;
  final String? successMessage; // ← thêm field này

  const AdminState({
    this.pendingSellers = const [],
    this.approvedSellers = const [],
    this.rejectedSellers = const [],
    this.sellersLoading = false,
    this.shippers = const [],
    this.shippersLoading = false,
    this.createShipperLoading = false,
    this.createShipperSuccess = false,
    this.errorMessage,
    this.successMessage,
  });

  AdminState copyWith({
    List<SellerRequestEntity>? pendingSellers,
    List<SellerRequestEntity>? approvedSellers,
    List<SellerRequestEntity>? rejectedSellers,
    bool? sellersLoading,
    List<Map<String, dynamic>>? shippers,
    bool? shippersLoading,
    bool? createShipperLoading,
    bool? createShipperSuccess,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false, // ← thêm
  }) => AdminState(
    pendingSellers: pendingSellers ?? this.pendingSellers,
    approvedSellers: approvedSellers ?? this.approvedSellers,
    rejectedSellers: rejectedSellers ?? this.rejectedSellers,
    sellersLoading: sellersLoading ?? this.sellersLoading,
    shippers: shippers ?? this.shippers,
    shippersLoading: shippersLoading ?? this.shippersLoading,
    createShipperLoading: createShipperLoading ?? this.createShipperLoading,
    createShipperSuccess: createShipperSuccess ?? this.createShipperSuccess,
    errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    successMessage: clearSuccess ? null : (successMessage ?? this.successMessage),
  );

  @override
  List<Object?> get props => [
    pendingSellers,
    approvedSellers,
    rejectedSellers,
    sellersLoading,
    shippers,
    shippersLoading,
    createShipperLoading,
    createShipperSuccess,
    errorMessage,
    successMessage,
  ];
}
