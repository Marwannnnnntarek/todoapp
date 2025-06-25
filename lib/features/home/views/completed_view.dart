import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/core/data/cubits/task/completed_tasks/cubit/completed_tasks_cubit.dart';
import 'package:todoapp/core/data/cubits/task/delete_task/cubit/delete_task_cubit.dart';
import 'package:todoapp/core/data/cubits/task/pending_tasks/cubit/pending_tasks_state.dart';

class CompletedView extends StatefulWidget {
  const CompletedView({super.key});

  @override
  State<CompletedView> createState() => _CompletedViewState();
}

class _CompletedViewState extends State<CompletedView> {
  // final DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    context.read<CompletedTasksCubit>().listenToCompletedTodos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompletedTasksCubit, PendingTaskState>(
      builder: (context, state) {
        if (state is PendingTaskLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PendingTaskLoaded) {
          final todos = state.todos;
          if (todos.isEmpty) {
            return const Center(
              child: Text(
                'No completed tasks',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              final dt = todo.timestamp.toDate();
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Slidable(
                  key: ValueKey(todo.id),
                  endActionPane: ActionPane(
                    motion: DrawerMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        onPressed: (context) async {
                          context.read<DeleteTaskCubit>().deleteTask(todo.id);
                        },
                      ),
                    ],
                  ),

                  child: ListTile(
                    title: Text(
                      todo.title,
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                    subtitle: Text(
                      todo.description,
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                    trailing: Text('${dt.day}/${dt.month}/${dt.year}'),
                  ),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
