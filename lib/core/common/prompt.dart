import 'package:flutter/material.dart';

class Prompt extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const Prompt({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text));
  }
}
