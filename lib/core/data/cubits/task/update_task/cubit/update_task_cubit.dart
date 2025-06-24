import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/data/cubits/task/update_task/cubit/update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  UpdateTaskCubit() : super(UpdateTaskInitial());

  final _collection = FirebaseFirestore.instance.collection('todos');

  Future<void> updateTask(String id, String title, String description) async {
    emit(UpdateTaskLoading());
    try {
      await _collection.doc(id).update({
        'title': title,
        'description': description,
      });
      emit(UpdateTaskSuccess());
    } catch (e) {
      emit(UpdateTaskError('Failed to update task: $e'));
    }
  }
}
