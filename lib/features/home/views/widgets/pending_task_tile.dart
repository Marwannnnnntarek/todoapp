import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/data/models/todo_model.dart';
import 'package:todoapp/core/data/cubits/task/update_task_status/cubit/update_task_status_cubit.dart';
import 'package:todoapp/core/data/cubits/task/delete_task/cubit/delete_task_cubit.dart';
import 'package:todoapp/core/helpers/todo_model_extension.dart';
import 'package:todoapp/features/home/views/widgets/show_task_dialog.dart';

class PendingTaskTile extends StatelessWidget {
  final TodoModel todo;

  const PendingTaskTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    // final dt = todo.timestamp.toDate();

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Slidable(
        key: ValueKey(todo.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.done,
              label: 'Complete',
              onPressed: (_) {
                context.read<UpdateTaskStatusCubit>().updateStatus(
                  todo.id,
                  true,
                );
              },
            ),
          ],
        ),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
              onPressed: (_) {
                showDialog(
                  context: context,
                  builder: (_) => ShowTaskDialog(todoModel: todo),
                );
              },
            ),
            SlidableAction(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              onPressed: (_) {
                context.read<DeleteTaskCubit>().deleteTask(todo.id);
              },
            ),
          ],
        ),
        child: ListTile(
          title: Text(todo.title),
          subtitle: Text(todo.description),
          trailing: Text(todo.formattedDate),
        ),
      ),
    );
  }
}
