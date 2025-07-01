import 'package:bloc/bloc.dart';
import 'package:todoapp/features/home/data/services/database_service.dart';
import 'package:todoapp/features/home/data/cubit/task_action_state.dart';

class TaskActionCubit extends Cubit<TaskActionState> {
  final DatabaseService db;

  TaskActionCubit(this.db) : super(TaskActionInitial());

  Future<void> addTask(String title, String description) async {
    emit(TaskActionLoading());
    try {
      await db.addTask(title, description);
      emit(TaskActionSuccess());
    } catch (e) {
      emit(TaskActionError(e.toString()));
    }
  }

  Future<void> deleteTask(String id) async {
    emit(TaskActionLoading());
    try {
      await db.deleteTask(id);
      emit(TaskActionSuccess());
    } catch (e) {
      emit(TaskActionError(e.toString()));
    }
  }

  Future<void> updateTask(String id, String title, String description) async {
    emit(TaskActionLoading());
    try {
      await db.updateTask(id, title, description);
      emit(TaskActionSuccess());
    } catch (e) {
      emit(TaskActionError(e.toString()));
    }
  }

  Future<void> updateTaskStatus(String id, bool completed) async {
    emit(TaskActionLoading());
    try {
      await db.updateTaskStatus(id, completed);
      emit(TaskActionSuccess());
    } catch (e) {
      emit(TaskActionError(e.toString()));
    }
  }
}
