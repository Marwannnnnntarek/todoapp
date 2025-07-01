// widgets/splash_message.dart
import 'package:flutter/material.dart';

class SplashMessage extends StatefulWidget {
  const SplashMessage({super.key});

  @override
  State<SplashMessage> createState() => _SplashMessageState();
}

class _SplashMessageState extends State<SplashMessage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: const Text(
        'Welcome to ToDo',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.5,
          fontFamily: 'Georgia',
        ),
      ),
    );
  }
}
