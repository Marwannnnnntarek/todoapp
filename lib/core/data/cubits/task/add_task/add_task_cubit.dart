// add_task_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:todoapp/core/data/cubits/task/add_task/add_task_state.dart';
import 'package:todoapp/core/data/services/database_service.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  final DatabaseService db;
  AddTaskCubit(this.db) : super(AddTaskInitial());

  Future<void> addTask(String title, String description) async {
    emit(AddTaskLoading());
    try {
      await db.addTask(title, description);
      emit(AddTaskSuccess());
    } catch (e) {
      emit(AddTaskError(e.toString()));
    }
  }
}
