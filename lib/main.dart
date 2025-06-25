import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/data/cubits/task/add_task/cubit/add_task_cubit.dart';
import 'package:todoapp/core/data/cubits/task/completed_tasks/cubit/completed_tasks_cubit.dart';
import 'package:todoapp/core/data/cubits/task/delete_task/cubit/delete_task_cubit.dart';
import 'package:todoapp/core/data/cubits/task/pending_tasks/cubit/pending_tasks_cubit.dart';
import 'package:todoapp/core/data/cubits/task/update_task/cubit/update_task_cubit.dart';
import 'package:todoapp/core/data/cubits/task/update_task_status/cubit/update_task_status_cubit.dart';
import 'package:todoapp/core/data/services/database_service.dart';
import 'package:todoapp/core/helpers/app_routes.dart';
import 'package:todoapp/core/data/cubits/auth/signin/cubit/signin_cubit.dart';
import 'package:todoapp/core/data/cubits/auth/signout/cubit/signout_cubit.dart';
import 'package:todoapp/core/data/cubits/auth/signup/cubit/signup_cubit.dart';
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
        BlocProvider<AddTaskCubit>(
          create: (context) => AddTaskCubit(DatabaseService()),
        ),
        BlocProvider<DeleteTaskCubit>(
          create: (context) => DeleteTaskCubit(DatabaseService()),
        ),
        BlocProvider<UpdateTaskCubit>(
          create: (context) => UpdateTaskCubit(DatabaseService()),
        ),
        BlocProvider<UpdateTaskStatusCubit>(
          create: (context) => UpdateTaskStatusCubit(DatabaseService()),
        ),
        BlocProvider<CompletedTasksCubit>(
          create: (context) => CompletedTasksCubit(DatabaseService()),
        ),
        BlocProvider<PendingTasksCubit>(
          create: (context) => PendingTasksCubit(DatabaseService()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRoutes.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
