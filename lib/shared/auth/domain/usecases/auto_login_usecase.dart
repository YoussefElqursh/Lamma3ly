import 'package:lamma3ly/shared/auth/domain/entities/user_entity.dart';
import 'package:lamma3ly/shared/auth/domain/repositories/auth_repository.dart';

/// Restores a session from stored tokens on app launch.
/// Returns null if no valid session exists.
class AutoLoginUseCase {
  final AuthRepository _repository;

  AutoLoginUseCase({required AuthRepository repository})
      : _repository = repository;

  Future<UserEntity?> call() => _repository.autoLogin();
}
