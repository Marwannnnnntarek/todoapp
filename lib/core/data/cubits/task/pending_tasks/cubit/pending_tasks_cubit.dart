import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todoapp/core/data/cubits/task/pending_tasks/cubit/pending_tasks_state.dart';
import 'package:todoapp/core/data/services/database_service.dart';

class PendingTasksCubit extends Cubit<PendingTaskState> {
  final DatabaseService db;
  StreamSubscription? _subscription;

  PendingTasksCubit(this.db) : super(PendingTaskInitial());

  void listenToPendingTodos() {
    emit(PendingTaskLoading());
    _subscription = db.pendingtodos.listen(
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
