import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract class SecureStorageService {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<void> deleteAll();
  Future<Map<String, String>> readAll();
}

@LazySingleton(as: SecureStorageService)
class SecureStorageServiceImpl implements SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageServiceImpl(this._storage);

  @override
  Future<void> write(String key, String value) async =>
      _storage.write(key: key, value: value);

  @override
  Future<String?> read(String key) async => _storage.read(key: key);

  @override
  Future<void> delete(String key) async => _storage.delete(key: key);

  @override
  Future<void> deleteAll() async => _storage.deleteAll();

  @override
  Future<Map<String, String>> readAll() async => _storage.readAll();
}