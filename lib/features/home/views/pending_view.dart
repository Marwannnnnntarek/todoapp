import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/home/data/cubit/task_stream_cubit.dart';
import 'package:todoapp/features/home/data/cubit/task_stream_state.dart';
import 'package:todoapp/features/home/views/widgets/pending_widgets/pending_task_tile.dart';

class PendingView extends StatefulWidget {
  const PendingView({super.key});

  @override
  State<PendingView> createState() => _PendingViewState();
}

class _PendingViewState extends State<PendingView> {
  @override
  void initState() {
    super.initState();
    context.read<TaskStreamCubit>().listenToPendingTodos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskStreamCubit, TaskStreamState>(
      builder: (context, state) {
        if (state is TodoStreamLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TodoStreamLoaded) {
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
              return PendingTaskTile(todo: todo);
            },
          );
        } else if (state is TodoStreamError) {
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
