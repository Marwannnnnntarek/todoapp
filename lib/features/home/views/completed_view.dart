import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/home/data/cubit/task_stream_cubit.dart';
import 'package:todoapp/features/home/data/cubit/task_stream_state.dart';
import 'package:todoapp/features/home/views/widgets/completed_widgets/completed_task_tile.dart';

class CompletedView extends StatefulWidget {
  const CompletedView({super.key});

  @override
  State<CompletedView> createState() => _CompletedViewState();
}

class _CompletedViewState extends State<CompletedView> {
  @override
  void initState() {
    super.initState();
    context.read<TaskStreamCubit>().listenToCompletedTodos();
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
