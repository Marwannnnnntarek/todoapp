import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/data/cubits/task/completed_tasks/cubit/completed_tasks_state.dart';
import 'package:todoapp/core/data/models/todo_model.dart';

class CompletedTasksCubit extends Cubit<CompletedTasksState> {
  CompletedTasksCubit() : super(CompletedTasksInitial());

  final _uid = FirebaseAuth.instance.currentUser!.uid;
  final _collection = FirebaseFirestore.instance.collection('todos');

  Future<void> fetchCompletedTasks() async {
    emit(CompletedTasksLoading());
    try {
      final snapshot =
          await _collection
              .where('uid', isEqualTo: _uid)
              .where('completed', isEqualTo: true)
              .orderBy('timestamp', descending: true)
              .get();

      final tasks =
          snapshot.docs.map((doc) {
            return TodoModel.fromJson(doc.data(), doc.id);
          }).toList();

      emit(CompletedTasksLoaded(tasks));
    } catch (e) {
      emit(CompletedTasksError('Error loading completed tasks: $e'));
    }
  }
}
