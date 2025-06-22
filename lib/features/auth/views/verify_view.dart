// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:todoapp/core/helpers/app_routes.dart';

// class VerifyView extends StatefulWidget {
//   const VerifyView({super.key});

//   @override
//   State<VerifyView> createState() => _VerifyViewState();
// }

// class _VerifyViewState extends State<VerifyView> {
//   bool isEmailVerified = false;
//   bool canResendEmail = false;
//   Timer? timer;

//   @override
//   void initState() {
//     super.initState();
//     isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

//     if (!isEmailVerified) {
//       sendVerificationEmail();

//       timer = Timer.periodic(
//         const Duration(seconds: 3),
//         (_) => checkEmailVerification(),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   Future<void> checkEmailVerification() async {
//     await FirebaseAuth.instance.currentUser!.reload();
//     final user = FirebaseAuth.instance.currentUser!;

//     if (user.emailVerified) {
//       setState(() => isEmailVerified = true);
//       timer?.cancel();
//       context.go(AppRoutes.home);
//     }
//   }

//   Future<void> sendVerificationEmail() async {
//     try {
//       final user = FirebaseAuth.instance.currentUser!;
//       await user.sendEmailVerification();
//       setState(() => canResendEmail = false);
//       await Future.delayed(const Duration(seconds: 5));
//       setState(() => canResendEmail = true);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error sending verification email: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Verify Email')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'A verification email has been sent to\n${FirebaseAuth.instance.currentUser!.email}.\nPlease check your inbox and click the link to verify your email.',
//               style: const TextStyle(fontSize: 16),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: canResendEmail ? sendVerificationEmail : null,
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size.fromHeight(50),
//               ),
//               icon: const Icon(Icons.email, size: 32),
//               label: const Text(
//                 'Resend Verification Email',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextButton(
//               style: TextButton.styleFrom(
//                 minimumSize: const Size.fromHeight(50),
//               ),
//               onPressed: () async {
//                 await FirebaseAuth.instance.signOut();
//                 context.go(AppRoutes.signin);
//               },
//               child: const Text('Cancel'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
