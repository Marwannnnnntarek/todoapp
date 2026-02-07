import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/features/auth/data/cubit/auth_cubit.dart';
import 'package:todoapp/features/auth/data/cubit/auth_state.dart';
import 'package:todoapp/features/auth/views/widgets/signin_widgets/email_field.dart';
import 'package:todoapp/features/auth/views/widgets/signin_widgets/password_field.dart';
import 'package:todoapp/features/auth/views/widgets/signin_widgets/button.dart';
import 'package:todoapp/features/auth/views/widgets/signin_widgets/prompt.dart';
import 'package:todoapp/core/helpers/app_routes.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Defer navigation to next frame so loading state is cleared and context is valid
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) return;
            context.go(AppRoutes.home);
            context.read<AuthCubit>().reset();
          });
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.red.shade700,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final errorMessage = state is AuthError ? state.message : null;

        return Form(
          key: _formKey,
          child: ListView(
            children: [
              if (errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade900.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade700),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade300, size: 22),
                      const SizedBox(width: 10),
                      Expanded(child: Text(errorMessage, style: TextStyle(color: Colors.red.shade200, fontSize: 14))),
                    ],
                  ),
                ),
              ],
              EmailField(
                controller: _emailController,
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              PasswordField(
                controller: _passwordController,
                validator: _validatePassword,
              ),
              const SizedBox(height: 50),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Button(
                    buttonText: 'Sign In',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().signin(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                      }
                    },
                  ),
              const SizedBox(height: 16),
              Prompt(
                text: "Don't have an account? Sign up",
                onPressed: () => context.go(AppRoutes.signup),
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () => context.go(AppRoutes.home),
                  child: Text(
                    'Continue as guest',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
