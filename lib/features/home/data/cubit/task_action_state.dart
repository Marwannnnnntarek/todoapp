class TaskActionState {}

class TaskActionInitial extends TaskActionState {}

class TaskActionLoading extends TaskActionState {}

class TaskActionSuccess extends TaskActionState {}

class TaskActionError extends TaskActionState {
  final String message;
  TaskActionError(this.message);
}
