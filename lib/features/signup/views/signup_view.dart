import 'package:flutter/material.dart';
import 'package:todoapp/core/common/header.dart';
import 'package:todoapp/features/signup/views/widgets/signup_form.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

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
        child: Column(
          children: const [
            SizedBox(height: 50),
            Header(title: 'Welcome', subTitle: 'Signup Here'),
            SizedBox(height: 35),
            Expanded(child: SignupForm()),
          ],
        ),
      ),
    );
  }
}
