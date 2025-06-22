import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/helpers/app_routes.dart';

class SignInPrompt extends StatelessWidget {
  const SignInPrompt();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.push(AppRoutes.signin),
      child: Text('Already have an account? Sign in'),
    );
  }
}
