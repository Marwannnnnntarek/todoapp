import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(SigninInitial());

  //sign in
  Future<void> signin({required String email, required String password}) async {
    emit(SigninLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SigninSuccess());
    } catch (e) {
      emit(SigninFailure());
      print('Sign in failed: $e');
    }
  }
}
