import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/core/data/cubits/task/delete_task/cubit/delete_task_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  DeleteTaskCubit() : super(DeleteTaskInitial());

  final _collection = FirebaseFirestore.instance.collection('todos');

  Future<void> deleteTask(String id) async {
    emit(DeleteTaskLoading());
    try {
      await _collection.doc(id).delete();
      emit(DeleteTaskSuccess());
    } catch (e) {
      emit(DeleteTaskError('Failed to delete task: $e'));
    }
  }
}
