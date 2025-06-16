import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/helpers/app_routes.dart';
import 'package:todoapp/features/auth/services/auth_service.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      User? user = await _authService.signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      if (user != null) {
        context.go(AppRoutes.home);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Registration failed')));
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
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                'Register Here',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 35),
              TextFormField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                style: const TextStyle(color: Colors.white),
                obscureText: true,
                validator: _validatePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.5,
                child: ElevatedButton(
                  onPressed: _handleSignUp,
                  child: const Text('Register'),
                ),
              ),
              TextButton(
                onPressed: () => context.push(AppRoutes.signin),
                child: const Text('Already have an account? Sign in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
