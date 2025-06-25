import 'package:bloc/bloc.dart';
import 'package:todoapp/core/data/cubits/task/add_task/add_task_state.dart';
import 'package:todoapp/core/data/services/database_service.dart';

class UpdateTaskStatusCubit extends Cubit<AddTaskState> {
  final DatabaseService db;
  UpdateTaskStatusCubit(this.db) : super(AddTaskInitial());

  Future<void> updateStatus(String id, bool completed) async {
    emit(AddTaskLoading());
    try {
      await db.updateTaskStatus(id, completed);
      emit(AddTaskSuccess());
    } catch (e) {
      emit(AddTaskError(e.toString()));
    }
  }
}
