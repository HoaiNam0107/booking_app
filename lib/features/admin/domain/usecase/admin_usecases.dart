import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/utils/either.dart';
import 'package:booking_app/core/utils/usecase.dart';
import 'package:booking_app/features/admin/domain/entities/seller_request_entity.dart';
import 'package:booking_app/features/admin/domain/repositories/admin_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

// ── WatchSellerRequests ───────────────────────────────────────────────────────
@lazySingleton
class WatchSellerRequestsUseCase {
  final AdminRepository _repo;
  WatchSellerRequestsUseCase(this._repo);

  Stream<Either<Failure, List<SellerRequestEntity>>> call(SellerStatus status) =>
      _repo.watchSellerRequests(status);
}

// ── ApproveSeller ─────────────────────────────────────────────────────────────
@lazySingleton
class ApproveSellerUseCase extends UseCase<void, String> {
  final AdminRepository _repo;
  ApproveSellerUseCase(this._repo);

  @override
  Future<Either<Failure, void>> call(String userId) => _repo.approveSeller(userId);
}

// ── RejectSeller ──────────────────────────────────────────────────────────────
@lazySingleton
class RejectSellerUseCase extends UseCase<void, RejectSellerParams> {
  final AdminRepository _repo;
  RejectSellerUseCase(this._repo);

  @override
  Future<Either<Failure, void>> call(RejectSellerParams params) =>
      _repo.rejectSeller(params.userId, params.reason);
}

class RejectSellerParams extends Equatable {
  final String userId;
  final String reason;
  const RejectSellerParams({required this.userId, required this.reason});
  @override
  List<Object?> get props => [userId, reason];
}

// ── CreateShipper ─────────────────────────────────────────────────────────────
@lazySingleton
class CreateShipperUseCase extends UseCase<void, CreateShipperParams> {
  final AdminRepository _repo;
  CreateShipperUseCase(this._repo);

  @override
  Future<Either<Failure, void>> call(CreateShipperParams params) => _repo.createShipper(
    email: params.email,
    password: params.password,
    displayName: params.displayName,
    phoneNumber: params.phoneNumber,
    dateOfBirth: params.dateOfBirth,
    vehicleType: params.vehicleType,
    licensePlate: params.licensePlate,
  );
}

class CreateShipperParams extends Equatable {
  final String email, password, displayName;
  final String phoneNumber, dateOfBirth, vehicleType, licensePlate;

  const CreateShipperParams({
    required this.email,
    required this.password,
    required this.displayName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.vehicleType,
    required this.licensePlate,
  });

  @override
  List<Object?> get props => [email, displayName];
}

// ── WatchShippers ─────────────────────────────────────────────────────────────
@lazySingleton
class WatchShippersUseCase {
  final AdminRepository _repo;
  WatchShippersUseCase(this._repo);

  Stream<Either<Failure, List<Map<String, dynamic>>>> call() => _repo.watchShippers();
}
