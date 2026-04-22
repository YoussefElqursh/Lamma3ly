import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lamma3ly/shared/auth/presentation/viewmodels/auth_cubit.dart';
import 'package:lamma3ly/shared/auth/presentation/viewmodels/auth_state.dart';
import 'package:lamma3ly/shared/auth/domain/entities/user_entity.dart';
import 'package:lamma3ly/routing/route_names.dart';
import 'package:lamma3ly/routing/customer_routes.dart';
import 'package:lamma3ly/routing/servicer_routes.dart';
import 'package:lamma3ly/routing/admin_routes.dart';
import 'package:lamma3ly/shared/auth/presentation/views/login_screen.dart';
import 'package:lamma3ly/shared/auth/presentation/views/register_screen.dart';

/// Top-level router configuration.
///
/// Uses [GoRouter.redirect] to perform role-based routing:
/// - Unauthenticated → login
/// - Customer → /customer/*
/// - Servicer → /servicer/*
/// - Admin → /admin/*
class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    debugLogDiagnostics: true,
    redirect: _globalRedirect,
    routes: [
      // ─── Auth Routes ───────────────────────────────────
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),

      // ─── Domain Routes ─────────────────────────────────
      ...CustomerRoutes.routes,
      ...ServicerRoutes.routes,
      ...AdminRoutes.routes,
    ],
  );

  /// Global redirect logic based on authentication state.
  static String? _globalRedirect(BuildContext context, GoRouterState state) {
    final authState = context.read<AuthCubit>().state;
    final currentPath = state.matchedLocation;

    final isOnAuthPage =
        currentPath == '/login' || currentPath == '/register';

    // Still loading — don't redirect yet
    if (authState is AuthInitial || authState is AuthLoading) {
      return null;
    }

    // Not authenticated → force to login
    if (authState is! AuthAuthenticated) {
      return isOnAuthPage ? null : '/login';
    }

    // Authenticated but on auth page → redirect to domain home
    if (isOnAuthPage) {
      return _homePathForRole(authState.user.role);
    }

    // Authenticated and on a valid page → allow
    return null;
  }

  /// Maps a [UserRole] to its domain home path.
  static String _homePathForRole(UserRole role) {
    return switch (role) {
      UserRole.customer => '/customer',
      UserRole.servicer => '/servicer',
      UserRole.admin => '/admin',
    };
  }
}
