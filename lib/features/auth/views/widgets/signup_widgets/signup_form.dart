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

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
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
          context.go(
            AppRoutes.verify,
          ); // Or AppRoutes.home if you change logic later
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration failed. Please try again.'),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Form(
          key: _formKey,
          child: ListView(
            children: [
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
                    buttonText: 'Sign Up',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().signup(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                      }
                    },
                  ),
              const SizedBox(height: 16),
              Prompt(
                text: 'Already have an account? Sign in',
                onPressed: () => context.go(AppRoutes.signin),
              ),
            ],
          ),
        );
      },
    );
  }
}
