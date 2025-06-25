import 'package:flutter/material.dart';
import 'package:todoapp/features/home/views/widgets/signout_button.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff1d2630),
      foregroundColor: Colors.white,
      title: const Text('Todo App'),
      actions: const [SignOutButton()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
