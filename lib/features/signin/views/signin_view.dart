import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/helpers/app_routes.dart';
import 'package:todoapp/core/data/cubits/signin/signin_cubit.dart';
import 'package:todoapp/core/common/email_field.dart';
import 'package:todoapp/core/common/password_field.dart';
import 'package:todoapp/core/common/button.dart';
import 'package:todoapp/core/common/header.dart';
import 'package:todoapp/core/common/prompt.dart';

// ignore: must_be_immutable
class SigninView extends StatelessWidget {
  SigninView({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

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
    return BlocListener<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninLoading) {
          _isLoading = true;
        } else if (state is SigninSuccess) {
          context.go(AppRoutes.home);
        } else if (state is SigninFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Signin failed. Check your credentials.'),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xff1d2630),
        appBar: AppBar(
          backgroundColor: const Color(0xff1d2630),
          foregroundColor: Colors.white,
          title: const Text('Sign In'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Header(
                  title: 'Welcome Back',
                  subTitle: 'Sign in to continue',
                ),
                const SizedBox(height: 35),
                EmailField(
                  controller: emailController,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 16),
                PasswordField(
                  controller: passwordController,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 50),
                _isLoading
                    ? const CircularProgressIndicator()
                    : Button(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SigninCubit>().signin(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                        }
                      },
                      buttonText: 'Sign In',
                    ),
                Prompt(
                  text: "Don't have an account? Sign up",
                  onPressed: () {
                    context.go(AppRoutes.signup);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
