import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Call when leaving auth screens so the next visit starts from initial state.
  void reset() => emit(AuthInitial());

  String _signInErrorMessage(Object e) {
    if (e is TimeoutException) {
      return 'Request timed out. Check your internet and try again.';
    }
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No account found for this email. Sign up first.';
        case 'wrong-password':
          return 'Wrong password. Please try again.';
        case 'invalid-credential':
          return 'Invalid email or password. Check and try again.';
        case 'invalid-email':
          return 'Invalid email format.';
        case 'user-disabled':
          return 'This account has been disabled.';
        case 'operation-not-allowed':
          return 'Email sign-in is not enabled. Check Firebase Console.';
        case 'network-request-failed':
          return 'Network error. Check your connection and try again.';
        case 'too-many-requests':
          return 'Too many attempts. Try again later.';
        default:
          return e.message ?? 'Sign in failed. Try again.';
      }
    }
    return 'Sign in failed. Please try again.';
  }

  String _signUpErrorMessage(Object e) {
    if (e is TimeoutException) {
      return 'Request timed out. Check your internet and try again.';
    }
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'This email is already registered. Sign in instead.';
        case 'weak-password':
          return 'Password is too weak. Use at least 6 characters.';
        case 'invalid-email':
          return 'Invalid email format.';
        case 'operation-not-allowed':
          return 'Email sign-up is not enabled. Check Firebase Console.';
        case 'network-request-failed':
          return 'Network error. Check your connection and try again.';
        default:
          return e.message ?? 'Sign up failed. Try again.';
      }
    }
    return 'Sign up failed. Please try again.';
  }

  // Sign In (no timeout — wait for Firebase to respond so we get the real error if any)
  Future<void> signin({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(_signInErrorMessage(e)));
    }
  }

  /// Sign in anonymously so you can use the app without email/password.
  Future<void> signInAsGuest() async {
    emit(AuthLoading());
    try {
      await _auth.signInAnonymously();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(
        e is FirebaseAuthException
            ? (e.code == 'operation-not-allowed'
                ? 'Guest sign-in is disabled. Enable Anonymous in Firebase Console.'
                : (e.message ?? 'Guest sign-in failed.'))
            : 'Guest sign-in failed. Try again.',
      ));
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
      emit(AuthError(_signUpErrorMessage(e)));
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
