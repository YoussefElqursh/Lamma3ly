import 'package:lamma3ly/shared/auth/domain/entities/user_entity.dart';
import 'package:lamma3ly/shared/auth/domain/repositories/auth_repository.dart';

/// Handles user login via email and password.
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase({required AuthRepository repository})
      : _repository = repository;

  Future<UserEntity> call({
    required String email,
    required String password,
  }) {
    return _repository.login(email: email, password: password);
  }
}
