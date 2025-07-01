import 'package:go_router/go_router.dart';
import 'package:todoapp/features/auth/views/signin_view.dart';
import 'package:todoapp/features/auth/views/signup_view.dart';
import 'package:todoapp/features/splash/views/splash_view.dart';
import 'package:todoapp/features/auth/views/email_verification_view.dart';
import 'package:todoapp/features/home/views/home_view.dart';

class AppRoutes {
  static const String verify = '/EmailVerificationView';
  static const String signup = '/SignupView';
  static const String signin = '/SigninView';
  static const String home = '/HomeView';
  static const String splash = '/SplashView';

  static final GoRouter router = GoRouter(
    initialLocation: splash,

    // No redirect logic — it's handled in SplashView
    redirect: (context, state) => null,

    routes: [
      GoRoute(
        path: verify,
        builder: (context, state) => EmailVerificationView(),
      ),
      GoRoute(path: signup, builder: (context, state) => SignupView()),
      GoRoute(path: signin, builder: (context, state) => SigninView()),
      GoRoute(path: home, builder: (context, state) => HomeView()),
      GoRoute(path: splash, builder: (context, state) => SplashView()),
    ],
  );
}
