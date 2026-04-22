import 'package:dio/dio.dart';
import 'package:lamma3ly/app/env/env_config.dart';
import 'package:lamma3ly/core/constants/app_constants.dart';
import 'package:lamma3ly/core/network/api_exceptions.dart';
import 'package:lamma3ly/core/network/interceptors/auth_interceptor.dart';
import 'package:lamma3ly/core/network/interceptors/logging_interceptor.dart';
import 'package:lamma3ly/core/storage/secure_storage_service.dart';

/// Centralized HTTP client wrapper around [Dio].
///
/// Provides typed error handling that converts [DioException]s
/// into domain-specific [AppException]s.
class ApiClient {
  late final Dio _dio;

  ApiClient({
    required EnvConfig config,
    required SecureStorageService storage,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        sendTimeout: AppConstants.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(AuthInterceptor(storage: storage));

    if (config.enableLogging) {
      _dio.interceptors.add(LoggingInterceptor());
    }
  }

  /// Exposes the underlying Dio instance for advanced usage.
  Dio get dio => _dio;

  // ─── HTTP Methods ──────────────────────────────────────

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ─── Error Handling ────────────────────────────────────

  AppException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.cancel:
        return const CancelledException();

      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);

      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return UnknownException(data: error.message);
    }
  }

  AppException _handleResponseError(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;
    final message = data is Map<String, dynamic>
        ? (data['message'] as String? ?? 'Server error')
        : 'Server error';

    if (statusCode == 401) {
      return const UnauthorizedException();
    }

    return ServerException(
      message: message,
      statusCode: statusCode,
      data: data,
    );
  }
}
