import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/data/cubits/task/completed_tasks/cubit/completed_tasks_cubit.dart';
import 'package:todoapp/core/data/cubits/task/pending_tasks/cubit/pending_tasks_state.dart';
import 'package:todoapp/features/home/views/widgets/completed_task_tile.dart';

class CompletedView extends StatefulWidget {
  const CompletedView({super.key});

  @override
  State<CompletedView> createState() => _CompletedViewState();
}

class _CompletedViewState extends State<CompletedView> {
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
              return CompletedTaskTile(todo: todos[index]);
            },
          );
        } else if (state is PendingTaskError) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
