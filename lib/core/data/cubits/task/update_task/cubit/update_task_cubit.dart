import 'package:bloc/bloc.dart';
import 'package:todoapp/core/data/cubits/task/add_task/add_task_state.dart';
import 'package:todoapp/core/data/services/database_service.dart';

class UpdateTaskCubit extends Cubit<AddTaskState> {
  final DatabaseService db;
  UpdateTaskCubit(this.db) : super(AddTaskInitial());

  Future<void> updateTask(String id, String title, String description) async {
    emit(AddTaskLoading());
    try {
      await db.updateTask(id, title, description);
      emit(AddTaskSuccess());
    } catch (e) {
      emit(AddTaskError(e.toString()));
    }
  }
}
