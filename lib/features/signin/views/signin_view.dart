import 'package:flutter/material.dart';
import 'package:todoapp/core/common/header.dart';
import 'widgets/signin_form.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

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
        child: Column(
          children: const [
            SizedBox(height: 50),
            Header(title: 'Welcome Back', subTitle: 'Sign in to continue'),
            SizedBox(height: 35),
            Expanded(child: SigninForm()),
          ],
        ),
      ),
    );
  }
}
