import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/common/email_field.dart';
import 'package:todoapp/core/common/password_field.dart';
import 'package:todoapp/core/common/button.dart';
import 'package:todoapp/core/common/prompt.dart';
import 'package:todoapp/core/helpers/app_routes.dart';
import 'package:todoapp/core/data/cubits/auth/signin/cubit/signin_cubit.dart';

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
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          context.go(AppRoutes.home);
        } else if (state is SigninFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Signin failed. Check your credentials.'),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is SigninLoading;

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
                    buttonText: 'Sign In',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SigninCubit>().signin(
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
            ],
          ),
        );
      },
    );
  }
}
