import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/helpers/app_routes.dart';

class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.push(AppRoutes.signup),
      child: const Text("Don't have an account? Sign up"),
    );
  }
}
