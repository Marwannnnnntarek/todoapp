import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/features/auth/views/signin_view.dart';
import 'package:todoapp/features/auth/views/signup_view.dart';
import 'package:todoapp/features/auth/views/verify_view.dart';
import 'package:todoapp/features/home/views/home_view.dart';

class AppRoutes {
  static const String verify = '/EmailVerificationScreen';
  static const String signup = '/SignupView';
  static const String signin = '/SigninView';
  static const String home = '/HomeView';

  static final GoRouter router = GoRouter(
    initialLocation: '/', // Root acts as the entry point
    // 🔁 Redirect logic based on auth state
    redirect: (context, state) {
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      final isAtSignin = state.matchedLocation == signin;
      final isAtSignup = state.matchedLocation == signup;

      // If not logged in, send to Signin
      if (!isLoggedIn && !(isAtSignin || isAtSignup)) {
        return signin;
      }

      // If logged in but trying to access auth pages
      if (isLoggedIn && (isAtSignin || isAtSignup)) {
        return home;
      }

      return null; // No redirect needed
    },

    routes: [
      // Optional root route that redirects based on auth state
      GoRoute(
        path: '/',
        redirect:
            (context, state) =>
                FirebaseAuth.instance.currentUser != null ? home : signin,
      ),
      GoRoute(
        path: verify,
        builder: (context, state) => EmailVerificationScreen(),
      ),
      GoRoute(path: signup, builder: (context, state) => SignupView()),
      GoRoute(path: signin, builder: (context, state) => SigninView()),
      GoRoute(path: home, builder: (context, state) => HomeView()),
    ],
  );
}
