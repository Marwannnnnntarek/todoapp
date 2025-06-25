import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/core/data/cubits/task/delete_task/cubit/delete_task_cubit.dart';
import 'package:todoapp/core/data/cubits/task/pending_tasks/cubit/pending_tasks_cubit.dart';
import 'package:todoapp/core/data/cubits/task/pending_tasks/cubit/pending_tasks_state.dart';
import 'package:todoapp/core/data/cubits/task/update_task_status/cubit/update_task_status_cubit.dart';
import 'package:todoapp/features/home/views/widgets/show_task_dialog.dart';

class PendingView extends StatefulWidget {
  const PendingView({super.key});

  @override
  State<PendingView> createState() => _PendingViewState();
}

class _PendingViewState extends State<PendingView> {
  @override
  void initState() {
    super.initState();
    context.read<PendingTasksCubit>().listenToPendingTodos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PendingTasksCubit, PendingTaskState>(
      builder: (context, state) {
        if (state is PendingTaskLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PendingTaskLoaded) {
          final todos = state.todos;
          if (todos.isEmpty) {
            return const Center(
              child: Text(
                'No pending tasks',
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Slidable(
                  key: ValueKey(todo.id),
                  endActionPane: ActionPane(
                    motion: DrawerMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.done,
                        label: 'Complete',
                        onPressed: (context) {
                          context.read<UpdateTaskStatusCubit>().updateStatus(
                            todo.id,
                            true,
                          );
                        },
                      ),
                    ],
                  ),
                  startActionPane: ActionPane(
                    motion: DrawerMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                        onPressed: (context) {
                          showDialog(
                            context: context,
                            builder:
                                (context) => ShowTaskDialog(todoModel: todo),
                          );
                        },
                      ),
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
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                    trailing: Text('${dt.day}/${dt.month}/${dt.year}'),
                  ),
                ),
              );
            },
          );
        } else if (state is PendingTaskError) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return Container();
      },
    );

    // return StreamBuilder<List<TodoModel>>(
    //   stream: databaseService.pendingtodos,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(child: CircularProgressIndicator());
    //     }

    //     if (snapshot.hasError) {
    //       return Center(
    //         child: Text(
    //           'Error: ${snapshot.error}',
    //           style: TextStyle(color: Colors.white),
    //         ),
    //       );
    //     }

    //     if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //       return const Center(
    //         child: Text(
    //           'No pending tasks',
    //           style: TextStyle(color: Colors.white),
    //         ),
    //       );
    //     }

    //     final todos = snapshot.data!;

    //     return ListView.builder(
    //       itemCount: todos.length,
    //       itemBuilder: (context, index) {
    //         final todo = todos[index];
    //         final dt = todo.timestamp.toDate();
    //         return Container(
    //           margin: EdgeInsets.all(10),
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(10),
    //           ),
    //           child: Slidable(
    //             key: ValueKey(todo.id),
    //             endActionPane: ActionPane(
    //               motion: DrawerMotion(),
    //               children: [
    //                 SlidableAction(
    //                   backgroundColor: Colors.blue,
    //                   foregroundColor: Colors.white,
    //                   icon: Icons.done,
    //                   label: 'Complete',
    //                   onPressed: (context) {
    //                     databaseService.updateTaskStatus(todo.id, true);
    //                   },
    //                 ),
    //               ],
    //             ),
    //             startActionPane: ActionPane(
    //               motion: DrawerMotion(),
    //               children: [
    //                 SlidableAction(
    //                   backgroundColor: Colors.amber,
    //                   foregroundColor: Colors.white,
    //                   icon: Icons.edit,
    //                   label: 'Edit',
    //                   onPressed: (context) {
    //                     showDialog(
    //                       context: context,
    //                       builder: (context) => ShowTaskDialog(todoModel: todo),
    //                     );
    //                   },
    //                 ),
    //                 SlidableAction(
    //                   backgroundColor: Colors.red,
    //                   foregroundColor: Colors.white,
    //                   icon: Icons.delete,
    //                   label: 'Delete',
    //                   onPressed: (context) async {
    //                     await databaseService.deleteTask(todo.id);
    //                   },
    //                 ),
    //               ],
    //             ),
    //             child: ListTile(
    //               title: Text(todo.title),
    //               subtitle: Text(todo.description),
    //               trailing: Text('${dt.day}/${dt.month}/${dt.year}'),
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
