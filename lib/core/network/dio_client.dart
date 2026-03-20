import 'package:booking_app/core/network/interceptors.dart';
import 'package:booking_app/core/service/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../contants/app_constants.dart';

@module
abstract class NetworkModule {
  BaseOptions get _baseOptions => BaseOptions(
    connectTimeout: const Duration(
      milliseconds: AppConstants.connectTimeoutMs,
    ),
    receiveTimeout: const Duration(
      milliseconds: AppConstants.receiveTimeoutMs,
    ),
    sendTimeout: const Duration(
      milliseconds: AppConstants.sendTimeoutMs,
    ),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  @lazySingleton
  Dio dio(Talker talker, SecureStorageService secureStorage) {
    final dio = Dio(_baseOptions);

    dio.interceptors.addAll([
      AuthInterceptor(secureStorage, talker),
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: false,
          printResponseData: true,
          printRequestData: true,
        ),
      ),
    ]);

    return dio;
  }
}