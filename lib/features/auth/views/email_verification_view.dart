import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/helpers/app_routes.dart';
import 'package:todoapp/features/auth/views/widgets/verify_widgets/email_verification_body.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _sendInitialVerificationEmail();
    _startVerificationCheckTimer();
  }

  void _sendInitialVerificationEmail() {
    try {
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } catch (e) {
      debugPrint('Error sending verification email: $e');
    }
  }

  void _startVerificationCheckTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _checkEmailVerified(),
    );
  }

  Future<void> _checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    if (user != null && user.emailVerified) {
      _timer?.cancel();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email successfully verified")),
        );
        context.go(AppRoutes.home);
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const EmailVerificationBody();
  }
}
