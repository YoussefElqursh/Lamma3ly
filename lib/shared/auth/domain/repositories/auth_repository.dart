import 'package:lamma3ly/shared/auth/domain/entities/user_entity.dart';

/// Abstract contract for authentication operations.
///
/// Implemented by [AuthRepositoryImpl] in the data layer.
/// Use cases depend on this interface, not the implementation.
abstract class AuthRepository {
  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  });

  Future<void> logout();

  /// Attempts to restore a session from stored tokens.
  /// Returns null if no valid session exists.
  Future<UserEntity?> autoLogin();

  /// Returns the currently stored user, if any.
  Future<UserEntity?> getCurrentUser();
}
