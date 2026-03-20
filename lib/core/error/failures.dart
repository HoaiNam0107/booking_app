import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// Lỗi liên quan đến server / API
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

/// Lỗi mạng (không có internet, timeout...)
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.statusCode});
}

/// Lỗi cache / local storage
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

/// Lỗi authentication (token hết hạn, unauthorized...)
class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.statusCode});
}

/// Lỗi validation input
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}

/// Lỗi không tìm thấy dữ liệu
class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message});
}

/// Lỗi không xác định
class UnknownFailure extends Failure {
  const UnknownFailure({required super.message});
}