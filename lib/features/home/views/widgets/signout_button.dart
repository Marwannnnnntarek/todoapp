import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/helpers/app_routes.dart';
import 'package:todoapp/core/data/cubits/signout/signout_cubit.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignoutCubit, SignoutState>(
      listener: (context, state) {
        if (state is SignoutLoading) {
          // Optionally show a loading indicator
        } else if (state is SignoutSuccess) {
          context.go(AppRoutes.signin);
        } else if (state is SignoutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign out failed. Please try again.')),
          );
        }
      },
      child: IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () {
          // Show confirmation dialog before signing out
          showDialog<bool>(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Confirm Sign Out'),
                  content: const Text('Are you sure you want to sign out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<SignoutCubit>().signout();
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
          );
        },
      ),
    );
  }
}
