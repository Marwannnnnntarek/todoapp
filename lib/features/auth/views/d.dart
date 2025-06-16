// // widgets/animated_form_field.dart
// import 'package:flutter/material.dart';

// class AnimatedFormField extends StatelessWidget {
//   final String label;
//   final bool obscureText;
//   final String? errorText;
//   final ValueChanged<String> onChanged;

//   const AnimatedFormField({
//     super.key,
//     required this.label,
//     required this.onChanged,
//     this.obscureText = false,
//     required this.errorText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeInOut,
//       child: TextField(
//         decoration: InputDecoration(
//           errorText: errorText,
//           labelText: label,
//           border: OutlineInputBorder(),
//         ),
//         obscureText: obscureText,
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
