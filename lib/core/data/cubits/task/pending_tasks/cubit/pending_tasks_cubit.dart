import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/data/cubits/task/pending_tasks/cubit/pending_tasks_state.dart';
import 'package:todoapp/core/data/models/todo_model.dart';

class PendingTasksCubit extends Cubit<PendingTasksState> {
  PendingTasksCubit() : super(PendingTasksInitial());

  final _uid = FirebaseAuth.instance.currentUser!.uid;
  final _collection = FirebaseFirestore.instance.collection('todos');

  Future<void> fetchPendingTasks() async {
    emit(PendingTasksLoading());
    try {
      final snapshot =
          await _collection
              .where('uid', isEqualTo: _uid)
              .where('completed', isEqualTo: false)
              .orderBy('timestamp', descending: true)
              .get();

      final tasks =
          snapshot.docs.map((doc) {
            return TodoModel.fromJson(doc.data(), doc.id);
          }).toList();

      emit(PendingTasksLoaded(tasks));
    } catch (e) {
      emit(PendingTasksError('Error loading pending tasks: $e'));
    }
  }
}
