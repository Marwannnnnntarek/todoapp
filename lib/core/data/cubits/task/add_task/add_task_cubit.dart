// add_task_cubit.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  final _uid = FirebaseAuth.instance.currentUser!.uid;
  final _collection = FirebaseFirestore.instance.collection('todos');

  Future<void> addTask(String title, String description) async {
    emit(AddTaskLoading());
    try {
      await _collection.add({
        'uid': _uid,
        'title': title,
        'description': description,
        'completed': false,
        'timestamp': FieldValue.serverTimestamp(),
      });
      emit(AddTaskSuccess());
    } catch (e) {
      emit(AddTaskError('Failed to add task: $e'));
    }
  }
}
