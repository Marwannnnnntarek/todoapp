import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //sign in
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user;
    } catch (e) {
      print('Sign in failed: $e');
      return null;
    }
  }

  //sign up
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'operation-not-allowed') {
        print(e.message);
      }
      print('Sign up failed: ${e.message}');
      return null;
    } catch (e) {
      print('Sign up failed: $e');
      return null;
    }
  }

  //sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('Sign out failed: $e');
    }
  }
}
