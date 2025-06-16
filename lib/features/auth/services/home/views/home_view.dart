import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/helpers/app_routes.dart';
import 'package:todoapp/core/models/todo_model.dart';
import 'package:todoapp/features/auth/services/auth_service.dart';
import 'package:todoapp/features/auth/services/database_service.dart';
import 'package:todoapp/features/auth/services/home/views/widgets/completed.dart';
import 'package:todoapp/features/auth/services/home/views/widgets/pending.dart';
import 'package:todoapp/features/auth/services/home/views/widgets/tab_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _buttonIndex = 0;

  final List<Widget> _views = [Pending(), Completed()];

  @override
  Widget build(BuildContext context) {
    final buttonLabels = ['Pending ', 'Completed '];

    return Scaffold(
      backgroundColor: const Color(0xff1d2630),
      appBar: AppBar(
        backgroundColor: const Color(0xff1d2630),
        foregroundColor: Colors.white,
        title: const Text('Todo App'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().signOut();
              context.go(AppRoutes.signin);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(buttonLabels.length, (index) {
              final isSelected = _buttonIndex == index;
              return TabButton(
                label: buttonLabels[index],
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _buttonIndex = index;
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _views[_buttonIndex],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(context),
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showTaskDialog(BuildContext context, {TodoModel? todoModel}) {
    final TextEditingController titleController = TextEditingController(
      text: todoModel?.title,
    );
    final TextEditingController descriptionController = TextEditingController(
      text: todoModel?.description,
    );
    final DatabaseService databaseService = DatabaseService();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            todoModel == null ? 'Add Task' : 'Edit Task',
            style: const TextStyle(color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                if (todoModel == null) {
                  await databaseService.addTask(
                    titleController.text,
                    descriptionController.text,
                  );
                } else {
                  await databaseService.updateTask(
                    todoModel.id,
                    titleController.text,
                    descriptionController.text,
                  );
                }
                context.pop();
              },
              child: Text(todoModel == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }
}
