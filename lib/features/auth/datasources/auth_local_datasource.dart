import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/core/service/secure_storage_service.dart';
import 'package:injectable/injectable.dart';

import '../../../core/contants/storage_keys.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUserId(String userId);
  Future<String?> getUserId();
  Future<void> clearSession();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageService _storage;
  AuthLocalDataSourceImpl(this._storage);

  @override
  Future<void> saveUserId(String userId) async {
    try {
      await _storage.write(StorageKeys.userId, userId);
    } catch (e) {
      throw CacheException(message: 'Lỗi khi lưu phiên: $e');
    }
  }

  @override
  Future<String?> getUserId() async {
    try {
      return await _storage.read(StorageKeys.userId);
    } catch (e) {
      throw CacheException(message: 'Lỗi khi đọc phiên: $e');
    }
  }

  @override
  Future<void> clearSession() async {
    try {
      await _storage.delete(StorageKeys.userId);
      await _storage.delete(StorageKeys.accessToken);
    } catch (e) {
      throw CacheException(message: 'Lỗi khi xoá phiên: $e');
    }
  }
}