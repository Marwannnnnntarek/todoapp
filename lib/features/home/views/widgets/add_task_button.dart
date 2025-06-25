import 'package:flutter/material.dart';
import 'package:todoapp/features/home/views/widgets/show_task_dialog.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.indigo,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const ShowTaskDialog(),
        );
      },
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
