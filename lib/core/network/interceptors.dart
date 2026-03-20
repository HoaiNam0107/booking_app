import 'package:booking_app/core/service/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../contants/storage_keys.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorage;
  final Talker _talker;

  AuthInterceptor(this._secureStorage, this._talker);

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = await _secureStorage.read(StorageKeys.accessToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    _talker.debug('🌐 [Request] ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _talker.debug('✅ [Response] ${response.statusCode} ${response.realUri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _talker.error('❌ [Error] ${err.response?.statusCode} ${err.message}');
    handler.next(err);
  }
}