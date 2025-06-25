import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todoapp/core/data/cubits/task/pending_tasks/cubit/pending_tasks_state.dart';
import 'package:todoapp/core/data/services/database_service.dart';

class CompletedTasksCubit extends Cubit<PendingTaskState> {
  final DatabaseService db;
  StreamSubscription? _subscription;

  CompletedTasksCubit(this.db) : super(PendingTaskInitial());

  void listenToCompletedTodos() {
    emit(PendingTaskLoading());
    _subscription = db.completedtodos.listen(
      (todos) => emit(PendingTaskLoaded(todos)),
      onError: (error) => emit(PendingTaskError(error.toString())),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
