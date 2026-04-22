import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lamma3ly/core/utils/extensions.dart';
import 'package:lamma3ly/core/utils/validators.dart';
import 'package:lamma3ly/core/widgets/app_button.dart';
import 'package:lamma3ly/core/widgets/app_text_field.dart';
import 'package:lamma3ly/shared/auth/domain/entities/user_entity.dart';
import 'package:lamma3ly/shared/auth/presentation/viewmodels/auth_cubit.dart';
import 'package:lamma3ly/shared/auth/presentation/viewmodels/auth_state.dart';

/// Registration screen with role selection.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  UserRole _selectedRole = UserRole.customer;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().register(
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          password: _passwordController.text,
          role: _selectedRole,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            context.showSnackBar(state.message, isError: true);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ─── Role Selector ──────────────────────
                  Text('I am a...', style: context.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  SegmentedButton<UserRole>(
                    segments: const [
                      ButtonSegment(
                        value: UserRole.customer,
                        label: Text('Customer'),
                        icon: Icon(Icons.person_outline),
                      ),
                      ButtonSegment(
                        value: UserRole.servicer,
                        label: Text('Provider'),
                        icon: Icon(Icons.build_outlined),
                      ),
                    ],
                    selected: {_selectedRole},
                    onSelectionChanged: (roles) {
                      setState(() => _selectedRole = roles.first);
                    },
                  ),
                  const SizedBox(height: 24),

                  // ─── Name ───────────────────────────────
                  AppTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    prefixIcon: const Icon(Icons.person_outlined),
                    textInputAction: TextInputAction.next,
                    validator: (v) => Validators.required(v, fieldName: 'Name'),
                  ),
                  const SizedBox(height: 16),

                  // ─── Email ──────────────────────────────
                  AppTextField(
                    controller: _emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                    textInputAction: TextInputAction.next,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 16),

                  // ─── Phone ──────────────────────────────
                  AppTextField(
                    controller: _phoneController,
                    label: 'Phone Number',
                    keyboardType: TextInputType.phone,
                    prefixIcon: const Icon(Icons.phone_outlined),
                    textInputAction: TextInputAction.next,
                    validator: Validators.phone,
                  ),
                  const SizedBox(height: 16),

                  // ─── Password ───────────────────────────
                  AppTextField(
                    controller: _passwordController,
                    label: 'Password',
                    obscureText: _obscurePassword,
                    prefixIcon: const Icon(Icons.lock_outlined),
                    textInputAction: TextInputAction.next,
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 16),

                  // ─── Confirm Password ───────────────────
                  AppTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    obscureText: _obscureConfirm,
                    prefixIcon: const Icon(Icons.lock_outlined),
                    textInputAction: TextInputAction.done,
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirm
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                      onPressed: () {
                        setState(() => _obscureConfirm = !_obscureConfirm);
                      },
                    ),
                    validator: (v) => Validators.confirmPassword(
                      v,
                      _passwordController.text,
                    ),
                    onSubmitted: (_) => _onRegister(),
                  ),
                  const SizedBox(height: 32),

                  // ─── Register Button ────────────────────
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return AppButton(
                        text: 'Create Account',
                        isLoading: state is AuthLoading,
                        onPressed: _onRegister,
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // ─── Login Link ─────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: context.textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () => context.pop(),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
