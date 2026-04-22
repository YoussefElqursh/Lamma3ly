import 'package:lamma3ly/shared/auth/domain/repositories/auth_repository.dart';

/// Clears tokens and logs the user out.
class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase({required AuthRepository repository})
      : _repository = repository;

  Future<void> call() => _repository.logout();
}
