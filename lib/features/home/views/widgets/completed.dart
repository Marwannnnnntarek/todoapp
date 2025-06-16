import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/core/models/todo_model.dart';
import 'package:todoapp/features/auth/services/database_service.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TodoModel>>(
      stream: databaseService.completedtodos,
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
                        await databaseService.deleteTask(todo.id);
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
      },
    );
  }
}
