import 'package:equatable/equatable.dart';
import 'package:lamma3ly/shared/auth/domain/entities/user_entity.dart';

/// All possible states for the authentication flow.
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any auth check has been performed.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Auth check or login/register is in progress.
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// User is authenticated and has a valid session.
class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

/// User is not authenticated (no session or logged out).
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// An error occurred during an auth operation.
class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
