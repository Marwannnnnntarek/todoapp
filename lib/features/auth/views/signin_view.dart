import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/helpers/app_routes.dart';
import 'package:todoapp/features/auth/services/auth_service.dart';
import 'package:todoapp/features/auth/views/widgets/email_field.dart';
import 'package:todoapp/features/auth/views/widgets/password_field.dart';
import 'package:todoapp/features/auth/views/widgets/register_and_signin_button.dart';
import 'package:todoapp/features/auth/views/widgets/header.dart';
import 'package:todoapp/features/auth/views/widgets/signup_prompt.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final AuthService _authService = AuthService();
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

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        User? user = await _authService.signIn(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        if (user != null) {
          context.go(AppRoutes.home);
        } else if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login failed. Check your credentials.'),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Authentication error')),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  : RegisterAndSigninButton(
                    onPressed: _handleSignIn,
                    buttonText: 'Sign In',
                  ),
              SignUpPrompt(),
            ],
          ),
        ),
      ),
    );
  }
}
