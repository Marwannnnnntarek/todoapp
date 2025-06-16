// // register_view.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:todo2/core/helpers/app_routes.dart';
// import 'package:todo2/features/auth/data/cubits/register/register_cubit.dart';

// import 'package:todo2/features/auth/data/cubits/register/register_states.dart';
// import 'package:todo2/features/auth/views/d.dart';

// class RegisterView extends StatefulWidget {
//   const RegisterView({super.key});

//   @override
//   State<RegisterView> createState() => _RegisterViewState();
// }

// class _RegisterViewState extends State<RegisterView>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//     _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final registerCubit = context.read<RegisterCubit>();

//     return BlocListener<RegisterCubit, RegisterState>(
//       listenWhen: (previous, current) => current.success,
//       listener: (context, state) {
//         if (state.success) {
//           context.go(AppRoutes.home);
//         }
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: SlideTransition(
//               position: _slideAnimation,
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Center(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         const Text(
//                           "Create your ToDo account",
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 40),
//                         BlocBuilder<RegisterCubit, RegisterState>(
//                           builder:
//                               (context, state) => Column(
//                                 children: [
//                                   AnimatedFormField(
//                                     label: "Name",
//                                     onChanged: registerCubit.updateName,
//                                     errorText: state.nameError,
//                                   ),
//                                   const SizedBox(height: 20),
//                                   AnimatedFormField(
//                                     label: "Email",
//                                     onChanged: registerCubit.updateEmail,
//                                     errorText: state.emailError,
//                                   ),
//                                   const SizedBox(height: 20),
//                                   AnimatedFormField(
//                                     label: "Password",
//                                     obscureText: true,
//                                     onChanged: registerCubit.updatePassword,
//                                     errorText: state.passwordError,
//                                   ),
//                                   if (state.generalError != null)
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 10),
//                                       child: Text(
//                                         state.generalError!,
//                                         style: const TextStyle(
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                     ),
//                                   const SizedBox(height: 30),
//                                   state.isLoading
//                                       ? const CircularProgressIndicator()
//                                       : ElevatedButton(
//                                         onPressed: registerCubit.register,
//                                         child: const Text("Register"),
//                                       ),
//                                   const SizedBox(height: 16),
//                                   TextButton(
//                                     onPressed:
//                                         () => context.go(AppRoutes.login),
//                                     child: const Text(
//                                       "Already have an account? Login",
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
