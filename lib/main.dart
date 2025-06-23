import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/helpers/app_routes.dart';
import 'package:todoapp/core/data/cubits/signin/signin_cubit.dart';
import 'package:todoapp/core/data/cubits/signout/signout_cubit.dart';
import 'package:todoapp/core/data/cubits/signup/signup_cubit.dart';
import 'package:todoapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SigninCubit>(create: (context) => SigninCubit()),
        BlocProvider<SignupCubit>(create: (context) => SignupCubit()),
        BlocProvider<SignoutCubit>(create: (context) => SignoutCubit()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRoutes.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
