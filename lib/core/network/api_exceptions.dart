import 'package:equatable/equatable.dart';

/// Base exception class for all API and application errors.
sealed class AppException extends Equatable implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const AppException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  List<Object?> get props => [message, statusCode, data];
}

/// Server returned an error response (4xx, 5xx).
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.statusCode,
    super.data,
  });
}

/// No internet or connection timeout.
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection. Please check your network.',
  });
}

/// Authentication failure (401).
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Session expired. Please log in again.',
    super.statusCode = 401,
  });
}

/// Request was cancelled.
class CancelledException extends AppException {
  const CancelledException({
    super.message = 'Request was cancelled.',
  });
}

/// Request timed out.
class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'Request timed out. Please try again.',
  });
}

/// Unknown or unexpected error.
class UnknownException extends AppException {
  const UnknownException({
    super.message = 'Something went wrong. Please try again.',
    super.data,
  });
}
