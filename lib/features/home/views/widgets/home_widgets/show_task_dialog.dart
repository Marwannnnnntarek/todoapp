import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/features/home/data/models/todo_model.dart';
import 'package:todoapp/features/home/data/cubit/task_action_cubit.dart';
import 'package:todoapp/features/home/data/cubit/task_action_state.dart';

class ShowTaskDialog extends StatefulWidget {
  final TodoModel? todoModel;

  const ShowTaskDialog({super.key, this.todoModel});

  @override
  State<ShowTaskDialog> createState() => _ShowTaskDialogState();
}

class _ShowTaskDialogState extends State<ShowTaskDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

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

    return MultiBlocListener(
      listeners: [
        BlocListener<TaskActionCubit, TaskActionState>(
          listener: (context, state) {
            if (state is TaskActionSuccess && !isEdit) {
              context.pop(); // Close on successful add
            } else if (state is TaskActionError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
        BlocListener<TaskActionCubit, TaskActionState>(
          listener: (context, state) {
            if (state is TaskActionSuccess && isEdit) {
              context.pop(); // Close on successful update
            } else if (state is TaskActionError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: AlertDialog(
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
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            onPressed: _handleSubmit,
            child: Text(isEdit ? 'Update' : 'Add'),
          ),
        ],
      ),
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

  void _handleSubmit() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) return;

    final isEdit = widget.todoModel != null;

    if (isEdit) {
      context.read<TaskActionCubit>().updateTask(
        widget.todoModel!.id,
        title,
        description,
      );
    } else {
      context.read<TaskActionCubit>().addTask(title, description);
    }
  }
}
