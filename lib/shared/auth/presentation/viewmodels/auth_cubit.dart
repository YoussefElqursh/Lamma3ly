import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamma3ly/core/network/api_exceptions.dart';
import 'package:lamma3ly/shared/auth/domain/entities/user_entity.dart';
import 'package:lamma3ly/shared/auth/domain/usecases/auto_login_usecase.dart';
import 'package:lamma3ly/shared/auth/domain/usecases/login_usecase.dart';
import 'package:lamma3ly/shared/auth/domain/usecases/logout_usecase.dart';
import 'package:lamma3ly/shared/auth/domain/usecases/register_usecase.dart';
import 'package:lamma3ly/shared/auth/presentation/viewmodels/auth_state.dart';

/// ViewModel (Cubit) for authentication.
///
/// Orchestrates use cases and emits [AuthState] changes.
/// The UI layer listens to these states and reacts accordingly.
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final AutoLoginUseCase _autoLoginUseCase;

  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required AutoLoginUseCase autoLoginUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _logoutUseCase = logoutUseCase,
        _autoLoginUseCase = autoLoginUseCase,
        super(const AuthInitial());

  /// Checks for an existing session on app startup.
  Future<void> checkAutoLogin() async {
    emit(const AuthLoading());
    try {
      final user = await _autoLoginUseCase();
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(const AuthUnauthenticated());
      }
    } on AppException catch (e) {
      emit(const AuthUnauthenticated());
      _logError('autoLogin', e.message);
    } catch (_) {
      emit(const AuthUnauthenticated());
    }
  }

  /// Performs email/password login.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      final user = await _loginUseCase(email: email, password: password);
      emit(AuthAuthenticated(user: user));
    } on AppException catch (e) {
      emit(AuthError(message: e.message));
    } catch (_) {
      emit(const AuthError(message: 'Something went wrong. Please try again.'));
    }
  }

  /// Registers a new user with role selection.
  Future<void> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  }) async {
    emit(const AuthLoading());
    try {
      final user = await _registerUseCase(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
        role: role,
      );
      emit(AuthAuthenticated(user: user));
    } on AppException catch (e) {
      emit(AuthError(message: e.message));
    } catch (_) {
      emit(const AuthError(message: 'Something went wrong. Please try again.'));
    }
  }

  /// Logs the user out and clears stored data.
  Future<void> logout() async {
    emit(const AuthLoading());
    try {
      await _logoutUseCase();
    } finally {
      emit(const AuthUnauthenticated());
    }
  }

  void _logError(String operation, String message) {
    // In production, send to crash reporting (e.g., Sentry/Firebase)
    // ignore: avoid_print
    print('AuthCubit.$operation error: $message');
  }
}
