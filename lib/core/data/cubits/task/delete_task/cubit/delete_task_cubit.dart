import 'package:bloc/bloc.dart';
import 'package:todoapp/core/data/cubits/task/add_task/cubit/add_task_state.dart';
import 'package:todoapp/core/data/services/database_service.dart';

class DeleteTaskCubit extends Cubit<AddTaskState> {
  final DatabaseService db;
  DeleteTaskCubit(this.db) : super(AddTaskInitial());

  Future<void> deleteTask(String id) async {
    emit(AddTaskLoading());
    try {
      await db.deleteTask(id);
      emit(AddTaskSuccess());
    } catch (e) {
      emit(AddTaskError(e.toString()));
    }
  }
}
