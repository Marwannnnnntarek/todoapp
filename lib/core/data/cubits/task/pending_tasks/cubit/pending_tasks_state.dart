import 'package:todoapp/core/data/models/todo_model.dart';

abstract class PendingTaskState {}

class PendingTaskInitial extends PendingTaskState {}

class PendingTaskLoading extends PendingTaskState {}

class PendingTaskLoaded extends PendingTaskState {
  final List<TodoModel> todos;
  PendingTaskLoaded(this.todos);
}

class PendingTaskError extends PendingTaskState {
  final String message;
  PendingTaskError(this.message);
}
