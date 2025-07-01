import 'package:todoapp/features/home/data/models/todo_model.dart';

abstract class TaskStreamState {}

class TodoStreamInitial extends TaskStreamState {}

class TodoStreamLoading extends TaskStreamState {}

class TodoStreamLoaded extends TaskStreamState {
  final List<TodoModel> todos;
  TodoStreamLoaded(this.todos);
}

class TodoStreamError extends TaskStreamState {
  final String message;
  TodoStreamError(this.message);
}
