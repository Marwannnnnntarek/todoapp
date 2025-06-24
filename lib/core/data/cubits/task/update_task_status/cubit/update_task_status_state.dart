part of 'update_task_status_cubit.dart';

abstract class UpdateTaskStatusState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateTaskStatusInitial extends UpdateTaskStatusState {}

class UpdateTaskStatusLoading extends UpdateTaskStatusState {}

class UpdateTaskStatusSuccess extends UpdateTaskStatusState {}

class UpdateTaskStatusError extends UpdateTaskStatusState {
  final String message;

  UpdateTaskStatusError(this.message);

  @override
  List<Object> get props => [message];
}
