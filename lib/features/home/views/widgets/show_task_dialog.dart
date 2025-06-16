import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/models/todo_model.dart';
import 'package:todoapp/features/auth/services/database_service.dart';

class ShowTaskDialog extends StatefulWidget {
  final TodoModel? todoModel;

  const ShowTaskDialog({super.key, this.todoModel});

  @override
  State<ShowTaskDialog> createState() => _ShowTaskDialogState();
}

class _ShowTaskDialogState extends State<ShowTaskDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  final _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todoModel?.title);
    _descriptionController = TextEditingController(
      text: widget.todoModel?.description,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.todoModel != null;

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        isEdit ? 'Edit Task' : 'Add Task',
        style: const TextStyle(color: Colors.black),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(_titleController, 'Title'),
            const SizedBox(height: 20),
            _buildTextField(_descriptionController, 'Description'),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          onPressed: _handleSubmit,
          child: Text(isEdit ? 'Update' : 'Add'),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    if (title.isEmpty || description.isEmpty) return;

    if (widget.todoModel == null) {
      await _databaseService.addTask(title, description);
    } else {
      await _databaseService.updateTask(
        widget.todoModel!.id,
        title,
        description,
      );
    }

    if (mounted) context.pop();
  }
}
