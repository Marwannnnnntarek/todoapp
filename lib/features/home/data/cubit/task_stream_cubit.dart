import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:todoapp/features/home/data/services/database_service.dart';
import 'package:todoapp/features/home/data/cubit/task_stream_state.dart';

class TaskStreamCubit extends Cubit<TaskStreamState> {
  final DatabaseService db;
  StreamSubscription? _subscription;

  TaskStreamCubit(this.db) : super(TodoStreamInitial());

  void listenToPendingTodos() {
    _cancelPreviousStream();
    emit(TodoStreamLoading());
    _subscription = db.pendingtodos.listen(
      (todos) => emit(TodoStreamLoaded(todos)),
      onError: (error) => emit(TodoStreamError(error.toString())),
    );
  }

  void listenToCompletedTodos() {
    _cancelPreviousStream();
    emit(TodoStreamLoading());
    _subscription = db.completedtodos.listen(
      (todos) => emit(TodoStreamLoaded(todos)),
      onError: (error) => emit(TodoStreamError(error.toString())),
    );
  }

  void _cancelPreviousStream() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  Future<void> close() {
    _cancelPreviousStream();
    return super.close();
  }
}
