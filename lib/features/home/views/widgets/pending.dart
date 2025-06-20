import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/core/models/todo_model.dart';
import 'package:todoapp/features/auth/services/database_service.dart';
import 'package:todoapp/features/home/views/widgets/show_task_dialog.dart';

class Pending extends StatefulWidget {
  const Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TodoModel>>(
      stream: databaseService.pendingtodos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No pending tasks',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final todos = snapshot.data!;

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
                        databaseService.updateTaskStatus(todo.id, true);
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
                          builder: (context) => ShowTaskDialog(todoModel: todo),
                        );
                      },
                    ),
                    SlidableAction(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                      onPressed: (context) async {
                        await databaseService.deleteTask(todo.id);
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
      },
    );
  }
}
