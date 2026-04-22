import 'package:dio/dio.dart';
import 'package:lamma3ly/core/storage/secure_storage_service.dart';
import 'package:lamma3ly/core/constants/app_constants.dart';

/// Injects the stored access token into outgoing requests
/// and handles 401 responses by clearing auth state.
class AuthInterceptor extends Interceptor {
  final SecureStorageService _storage;

  AuthInterceptor({required SecureStorageService storage})
      : _storage = storage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(AppConstants.accessTokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _storage.deleteAll();
      // Optionally: trigger navigation to login via a global event bus
    }
    handler.next(err);
  }
}
