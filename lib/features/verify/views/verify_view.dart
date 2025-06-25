import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/helpers/app_routes.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _sendVerificationEmail();
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _checkEmailVerified(),
    );
  }

  void _sendVerificationEmail() {
    try {
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } catch (e) {
      debugPrint('Error sending email verification: $e');
    }
  }

  Future<void> _checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    if (user != null && user.emailVerified) {
      setState(() => isEmailVerified = true);
      timer?.cancel();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email successfully verified")),
      );
      context.go(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email ?? '';

    return Scaffold(
      backgroundColor: const Color(0xff1d2630),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                'Check your\nEmail',
                style: TextStyle(color: Colors.white, fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'We have sent a verification link to $email. Please check your inbox and verify your email to continue.',
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const CircularProgressIndicator(),
              const SizedBox(height: 12),
              const Text(
                'Verifying email...',
                style: TextStyle(color: Colors.white60),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.currentUser
                        ?.sendEmailVerification();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Verification email resent.'),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to resend email: $e')),
                    );
                  }
                },
                child: const Text('Resend Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
