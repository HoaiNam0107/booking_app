import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/utils/either.dart';
import 'package:booking_app/features/auth/data/mappers/user_mapper.dart';
import 'package:booking_app/features/auth/datasources/auth_local_datasource.dart';
import 'package:booking_app/features/auth/datasources/auth_remote_datasource.dart';
import 'package:booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:booking_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  AuthRepositoryImpl(this._remote, this._local);

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final model = await _remote.loginWithEmailPassword(
        email: email,
        password: password,
      );
      await _local.saveUserId(model.id);
      return Right(UserMapper.toEntity(model));
    } on AuthException catch (e) {
      // Bao gồm cả trường hợp seller bị rejected (statusCode 403)
      return Left(AuthFailure(message: e.message, statusCode: e.statusCode));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> registerCustomer({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
    required String dateOfBirth,
    required String address,
  }) async {
    try {
      final model = await _remote.registerWithEmailPassword(
        email: email,
        password: password,
        extraData: {
          'displayName': displayName,
          'phoneNumber': phoneNumber,
          'dateOfBirth': dateOfBirth,
          'address': address,
          'role': 'customer',
        },
      );
      await _local.saveUserId(model.id);
      return Right(UserMapper.toEntity(model));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message, statusCode: e.statusCode));
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    }
  }

  @override
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
  }) async {
    try {
      final model = await _remote.registerWithEmailPassword(
        email: email,
        password: password,
        extraData: {
          'displayName': displayName,
          'phoneNumber': phoneNumber,
          'dateOfBirth': dateOfBirth,
          'address': address,
          'role': 'seller',
          'shopName': shopName,
          'shopAddress': shopAddress,
          'shopCategory': shopCategory,
          // sellerStatus = 'pending' được set trong datasource
        },
      );
      await _local.saveUserId(model.id);
      return Right(UserMapper.toEntity(model));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message, statusCode: e.statusCode));
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remote.logout();
      await _local.clearSession();
      return const Right(null);
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final uid = await _local.getUserId();
      if (uid == null) return const Right(null);
      final model = await _remote.fetchCurrentUser(uid);
      if (model == null) return const Right(null);
      return Right(UserMapper.toEntity(model));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _remote.authStateChanges.asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      final model = await _remote.fetchCurrentUser(firebaseUser.uid);
      if (model == null) return null;
      return UserMapper.toEntity(model);
    });
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await _remote.sendPasswordResetEmail(email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> clearLocalSession() async {
    try {
      await _local.clearSession();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}