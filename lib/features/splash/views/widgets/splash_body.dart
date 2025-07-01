// widgets/splash_scaffold.dart
import 'package:flutter/material.dart';

class SplashBody extends StatelessWidget {
  final Widget child;

  const SplashBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1d2630),
      body: Center(child: child),
    );
  }
}
