import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterAndSigninButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const RegisterAndSigninButton({
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.5,
      child: ElevatedButton(onPressed: onPressed, child: Text(buttonText)),
    );
  }
}
