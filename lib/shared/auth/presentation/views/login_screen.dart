import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lamma3ly/core/utils/extensions.dart';
import 'package:lamma3ly/core/utils/validators.dart';
import 'package:lamma3ly/core/widgets/app_button.dart';
import 'package:lamma3ly/core/widgets/app_text_field.dart';
import 'package:lamma3ly/routing/route_names.dart';
import 'package:lamma3ly/shared/auth/presentation/viewmodels/auth_cubit.dart';
import 'package:lamma3ly/shared/auth/presentation/viewmodels/auth_state.dart';

/// Login screen — shared across all domains.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            context.showSnackBar(state.message, isError: true);
          }
          // Navigation is handled by the router's redirect logic
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ─── Header ───────────────────────────
                    Icon(
                      Icons.handyman_rounded,
                      size: 64,
                      color: context.colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome Back',
                      style: context.textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to continue',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurface.withAlpha(153),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // ─── Email Field ──────────────────────
                    AppTextField(
                      controller: _emailController,
                      label: 'Email',
                      hint: 'you@example.com',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.email_outlined),
                      validator: Validators.email,
                    ),
                    const SizedBox(height: 16),

                    // ─── Password Field ───────────────────
                    AppTextField(
                      controller: _passwordController,
                      label: 'Password',
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                      validator: Validators.password,
                      onSubmitted: (_) => _onLogin(),
                    ),
                    const SizedBox(height: 8),

                    // ─── Forgot Password ──────────────────
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Navigate to forgot password
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ─── Login Button ─────────────────────
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return AppButton(
                          text: 'Login',
                          isLoading: state is AuthLoading,
                          onPressed: _onLogin,
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // ─── Register Link ────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: context.textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () => context.pushNamed(RouteNames.register),
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
