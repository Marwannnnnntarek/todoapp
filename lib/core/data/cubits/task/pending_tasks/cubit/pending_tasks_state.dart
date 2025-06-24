import 'package:todoapp/core/data/models/todo_model.dart';

abstract class PendingTasksState {}

class PendingTasksInitial extends PendingTasksState {}

class PendingTasksLoading extends PendingTasksState {}

class PendingTasksLoaded extends PendingTasksState {
  final List<TodoModel> tasks;
  PendingTasksLoaded(this.tasks);
}

class PendingTasksError extends PendingTasksState {
  final String message;
  PendingTasksError(this.message);
}
