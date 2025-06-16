// register_state.dart
class RegisterState {
  final String name;
  final String email;
  final String password;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? generalError;
  final bool isLoading;
  final bool success;

  RegisterState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.nameError,
    this.emailError,
    this.passwordError,
    this.generalError,
    this.isLoading = false,
    this.success = false,
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    String? nameError,
    String? emailError,
    String? passwordError,
    String? generalError,
    bool? isLoading,
    bool? success,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      nameError: nameError,
      emailError: emailError,
      passwordError: passwordError,
      generalError: generalError,
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
    );
  }
}
