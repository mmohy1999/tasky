part of 'add_task_cubit.dart';


@immutable
sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}
final class AddTaskLoading<T> extends AddTaskState {}

final class AddTaskSuccess<AddTaskResponse> extends AddTaskState {
  final AddTaskResponse data;

  AddTaskSuccess(this.data);
}

final class AddTaskError<T> extends AddTaskState {
  final String error;

  AddTaskError({required this.error});
}

final class ChangeImageTask extends AddTaskState {}
final class SetImageTaskError<T> extends AddTaskState {
  final String error;

  SetImageTaskError({required this.error});
}

final class GetTaskLoading<T> extends AddTaskState {}

final class GetTaskSuccess<AddTaskResponse> extends AddTaskState {
  final AddTaskResponse data;

  GetTaskSuccess(this.data);
}

final class GetTaskError<T> extends AddTaskState {
  final String error;

  GetTaskError({required this.error});
}



final class EditTaskLoading<T> extends AddTaskState {}


final class EditTaskSuccess<EditTaskResponse> extends AddTaskState {
  final EditTaskResponse data;

  EditTaskSuccess(this.data);
}

final class EditTaskError<T> extends AddTaskState {
  final String error;

  EditTaskError({required this.error});
}