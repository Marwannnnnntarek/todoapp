import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/features/home/data/models/todo_model.dart';
import 'package:todoapp/core/helpers/todo_model_extension.dart';
import 'package:todoapp/features/home/data/cubit/task_action_cubit.dart';

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
                showDialog<bool>(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Confirm Delete'),
                        content: const Text('Are you sure you want to delete?'),
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<TaskActionCubit>().deleteTask(
                                todo.id,
                              );
                              context.pop(true);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                );
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
