import 'dart:convert';

import 'package:lamma3ly/core/constants/app_constants.dart';
import 'package:lamma3ly/core/storage/secure_storage_service.dart';
import 'package:lamma3ly/shared/auth/data/api/auth_api_service.dart';
import 'package:lamma3ly/shared/auth/data/models/user_model.dart';
import 'package:lamma3ly/shared/auth/domain/entities/user_entity.dart';
import 'package:lamma3ly/shared/auth/domain/repositories/auth_repository.dart';

/// Concrete implementation of [AuthRepository].
///
/// Coordinates between [AuthApiService] for network calls
/// and [SecureStorageService] for persisting tokens/user data.
class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApi;
  final SecureStorageService _storage;

  AuthRepositoryImpl({
    required AuthApiService authApi,
    required SecureStorageService storage,
  })  : _authApi = authApi,
        _storage = storage;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final response = await _authApi.login(
      email: email,
      password: password,
    );

    await _persistAuthData(response.accessToken, response.refreshToken, response.user);

    return UserModel.fromJson(response.user);
  }

  @override
  Future<UserEntity> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  }) async {
    final response = await _authApi.register(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
      role: role.name,
    );

    await _persistAuthData(response.accessToken, response.refreshToken, response.user);

    return UserModel.fromJson(response.user);
  }

  @override
  Future<void> logout() async {
    try {
      await _authApi.logout();
    } finally {
      await _storage.deleteAll();
    }
  }

  @override
  Future<UserEntity?> autoLogin() async {
    final token = await _storage.read(AppConstants.accessTokenKey);
    if (token == null || token.isEmpty) return null;

    final userData = await _storage.read(AppConstants.userDataKey);
    if (userData == null) return null;

    try {
      final json = jsonDecode(userData) as Map<String, dynamic>;
      return UserModel.fromJson(json);
    } catch (_) {
      await _storage.deleteAll();
      return null;
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userData = await _storage.read(AppConstants.userDataKey);
    if (userData == null) return null;

    try {
      final json = jsonDecode(userData) as Map<String, dynamic>;
      return UserModel.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  // ─── Private Helpers ───────────────────────────────────

  Future<void> _persistAuthData(
    String accessToken,
    String refreshToken,
    Map<String, dynamic> user,
  ) async {
    await _storage.write(AppConstants.accessTokenKey, accessToken);
    await _storage.write(AppConstants.refreshTokenKey, refreshToken);
    await _storage.write(AppConstants.userDataKey, jsonEncode(user));
    await _storage.write(AppConstants.userRoleKey, user['role'] as String);
  }
}
