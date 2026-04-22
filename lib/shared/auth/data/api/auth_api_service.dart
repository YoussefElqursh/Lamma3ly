import 'package:lamma3ly/core/network/api_client.dart';
import 'package:lamma3ly/core/network/api_endpoints.dart';
import 'package:lamma3ly/shared/auth/data/models/auth_response_model.dart';

/// Handles raw HTTP calls for authentication endpoints.
class AuthApiService {
  final ApiClient _apiClient;

  AuthApiService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );
    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<AuthResponseModel> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.register,
      data: {
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'password': password,
        'role': role,
      },
    );
    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> getProfile() async {
    final response = await _apiClient.get(ApiEndpoints.profile);
    return response.data as Map<String, dynamic>;
  }

  Future<void> logout() async {
    await _apiClient.post(ApiEndpoints.logout);
  }
}
