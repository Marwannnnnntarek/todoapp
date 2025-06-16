import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/helpers/app_routes.dart';
import 'package:todoapp/features/auth/data/services/auth_service.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1d2630),
      appBar: AppBar(
        backgroundColor: Color(0xff1d2630),
        foregroundColor: Colors.white,
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Welcome',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Register Here',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 35),
            TextField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width / 1.5,
              child: ElevatedButton(
                onPressed: () async {
                  User? user = await _authService.signUp(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                  if (user != null) {
                    context.go(AppRoutes.home);
                  }
                },
                child: Text('Register'),
              ),
            ),
            TextButton(
              onPressed: () => context.push(AppRoutes.signin),
              child: Text('Already have an account? Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}
