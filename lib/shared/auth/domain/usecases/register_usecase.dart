import 'package:lamma3ly/shared/auth/domain/entities/user_entity.dart';
import 'package:lamma3ly/shared/auth/domain/repositories/auth_repository.dart';

/// Handles new user registration with role selection.
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase({required AuthRepository repository})
      : _repository = repository;

  Future<UserEntity> call({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  }) {
    return _repository.register(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
      role: role,
    );
  }
}
