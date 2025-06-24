import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'update_task_status_state.dart';

class UpdateTaskStatusCubit extends Cubit<UpdateTaskStatusState> {
  UpdateTaskStatusCubit() : super(UpdateTaskStatusInitial());

  Future<void> updateTaskStatus(String id, bool completed) async {
    emit(UpdateTaskStatusLoading());

    try {
      await FirebaseFirestore.instance.collection('todos').doc(id).update({
        'completed': completed,
      });

      emit(UpdateTaskStatusSuccess());
    } catch (e) {
      emit(UpdateTaskStatusError(e.toString()));
    }
  }
}
