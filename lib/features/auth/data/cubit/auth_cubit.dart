import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign In
  Future<void> signin({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Sign in failed: $e'));
    }
  }

  // Sign Up
  Future<void> signup({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Sign up failed: $e'));
    }
  }

  // Sign Out
  Future<void> signout() async {
    emit(AuthLoading());
    try {
      await _auth.signOut();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Sign out failed: $e'));
    }
  }
}
