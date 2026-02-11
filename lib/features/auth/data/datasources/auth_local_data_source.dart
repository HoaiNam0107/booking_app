import 'package:injectable/injectable.dart';

import '../../../../core/storage/secure_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveRefreshToken(String token);
  Future<String?> getRefreshToken();
  Future<void> clear();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorage _secureStorage;

  AuthLocalDataSourceImpl(this._secureStorage);

  @override
  Future<void> saveRefreshToken(String token) {
    return _secureStorage.saveRefreshToken(token);
  }

  @override
  Future<String?> getRefreshToken() {
    return _secureStorage.getRefreshToken();
  }

  @override
  Future<void> clear() {
    return _secureStorage.clear();
  }
}