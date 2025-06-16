// // login_state.dart
// class LoginState {
//   final String email;
//   final String password;
//   final String? emailError;
//   final String? passwordError;
//   final String? generalError;
//   final bool isLoading;
//   final bool success;

//   LoginState({
//     this.email = '',
//     this.password = '',
//     this.emailError,
//     this.passwordError,
//     this.generalError,
//     this.isLoading = false,
//     this.success = false,
//   });

//   LoginState copyWith({
//     String? email,
//     String? password,
//     String? emailError,
//     String? passwordError,
//     String? generalError,
//     bool? isLoading,
//     bool? success,
//   }) {
//     return LoginState(
//       email: email ?? this.email,
//       password: password ?? this.password,
//       emailError: emailError,
//       passwordError: passwordError,
//       generalError: generalError,
//       isLoading: isLoading ?? this.isLoading,
//       success: success ?? this.success,
//     );
//   }
// }
