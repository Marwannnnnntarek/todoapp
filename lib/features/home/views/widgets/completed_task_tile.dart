import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/core/data/models/todo_model.dart';
import 'package:todoapp/core/data/cubits/task/delete_task/cubit/delete_task_cubit.dart';
import 'package:todoapp/core/helpers/todo_model_extension.dart';

class CompletedTaskTile extends StatelessWidget {
  final TodoModel todo;

  const CompletedTaskTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Slidable(
        key: ValueKey(todo.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              onPressed: (context) {
                context.read<DeleteTaskCubit>().deleteTask(todo.id);
              },
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            todo.title,
            style: const TextStyle(decoration: TextDecoration.lineThrough),
          ),
          subtitle: Text(
            todo.description,
            style: const TextStyle(decoration: TextDecoration.lineThrough),
          ),
          trailing: Text(todo.formattedDate),
        ),
      ),
    );
  }
}
