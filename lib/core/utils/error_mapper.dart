import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/core/error/failures.dart';
import 'package:dio/dio.dart';

Failure mapDioExceptionToFailure(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const NetworkFailure(message: 'Kết nối bị timeout, vui lòng thử lại.');

    case DioExceptionType.connectionError:
      return const NetworkFailure(message: 'Không có kết nối mạng.');

    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final message = _extractErrorMessage(e.response);
      if (statusCode == 401 || statusCode == 403) {
        return AuthFailure(message: message, statusCode: statusCode);
      }
      if (statusCode == 404) {
        return NotFoundFailure(message: message);
      }
      return ServerFailure(message: message, statusCode: statusCode);

    case DioExceptionType.cancel:
      return const NetworkFailure(message: 'Yêu cầu bị huỷ.');

    default:
      return UnknownFailure(message: e.message ?? 'Lỗi không xác định.');
  }
}

Failure mapExceptionToFailure(Exception e) {
  if (e is ServerException) {
    return ServerFailure(message: e.message, statusCode: e.statusCode);
  }
  if (e is NetworkException) {
    return NetworkFailure(message: e.message);
  }
  if (e is CacheException) {
    return CacheFailure(message: e.message);
  }
  if (e is AuthException) {
    return AuthFailure(message: e.message, statusCode: e.statusCode);
  }
  if (e is UnknownException) {
    return UnknownFailure(message: e.message);
  }
  return UnknownFailure(message: e.toString());
}

String _extractErrorMessage(Response? response) {
  if (response?.data == null) return 'Lỗi server không xác định.';
  try {
    final data = response!.data as Map<String, dynamic>;
    return data['message'] as String? ?? data['error'] as String? ?? 'Lỗi server.';
  } catch (_) {
    return 'Lỗi server không xác định.';
  }
}
