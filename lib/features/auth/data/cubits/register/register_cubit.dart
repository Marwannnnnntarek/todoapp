// // register_cubit.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:todo2/features/auth/data/cubits/register/register_states.dart';

// class RegisterCubit extends Cubit<RegisterState> {
//   RegisterCubit() : super(RegisterState());

//   void updateName(String name) {
//     emit(state.copyWith(name: name, nameError: null));
//   }

//   void updateEmail(String email) {
//     emit(state.copyWith(email: email, emailError: null));
//   }

//   void updatePassword(String password) {
//     emit(state.copyWith(password: password, passwordError: null));
//   }

//   Future<void> register() async {
//     if (!_validateInputs()) return;

//     emit(state.copyWith(isLoading: true, generalError: null));
//     try {
//       final userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//             email: state.email,
//             password: state.password,
//           );

//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .set({'name': state.name, 'email': state.email});

//       emit(state.copyWith(success: true, isLoading: false));
//     } on FirebaseAuthException catch (e) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           generalError: e.message ?? 'An error occurred',
//         ),
//       );
//     }
//   }

//   bool _validateInputs() {
//     String? nameError;
//     String? emailError;
//     String? passwordError;

//     if (state.name.trim().isEmpty) {
//       nameError = 'Name cannot be empty';
//     }
//     if (state.email.isEmpty || !state.email.contains('@')) {
//       emailError = 'Enter a valid email';
//     }
//     if (state.password.length < 6) {
//       passwordError = 'Password must be at least 6 characters';
//     }

//     if (nameError != null || emailError != null || passwordError != null) {
//       emit(
//         state.copyWith(
//           nameError: nameError,
//           emailError: emailError,
//           passwordError: passwordError,
//         ),
//       );
//       return false;
//     }
//     return true;
//   }
// }
