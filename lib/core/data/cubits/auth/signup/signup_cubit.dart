import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  //sign up
  Future<void> signup({required String email, required String password}) async {
    emit(SignupLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure());
      print('Sign up failed: $e');
    }
  }
}
