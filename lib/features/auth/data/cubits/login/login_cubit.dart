// // login_cubit.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'login_state.dart';

// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit() : super(LoginState());

//   void updateEmail(String email) {
//     emit(state.copyWith(email: email, emailError: null));
//   }

//   void updatePassword(String password) {
//     emit(state.copyWith(password: password, passwordError: null));
//   }

//   Future<void> login() async {
//     if (!_validateInputs()) return;

//     emit(state.copyWith(isLoading: true, generalError: null));
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: state.email,
//         password: state.password,
//       );
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
//     String? emailError;
//     String? passwordError;

//     if (state.email.isEmpty || !state.email.contains('@')) {
//       emailError = 'Please enter a valid email';
//     }

//     if (state.password.length < 6) {
//       passwordError = 'Password must be at least 6 characters';
//     }

//     if (emailError != null || passwordError != null) {
//       emit(
//         state.copyWith(emailError: emailError, passwordError: passwordError),
//       );
//       return false;
//     }
//     return true;
//   }
// }
