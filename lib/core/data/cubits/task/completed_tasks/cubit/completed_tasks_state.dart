import 'package:todoapp/core/data/models/todo_model.dart';

abstract class CompletedTasksState {}

class CompletedTasksInitial extends CompletedTasksState {}

class CompletedTasksLoading extends CompletedTasksState {}

class CompletedTasksLoaded extends CompletedTasksState {
  final List<TodoModel> tasks;
  CompletedTasksLoaded(this.tasks);
}

class CompletedTasksError extends CompletedTasksState {
  final String message;
  CompletedTasksError(this.message);
}
