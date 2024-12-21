part of 'task_cubit.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}
final class TaskLoading extends TaskState {}
final class TaskSuccess<T> extends TaskState {
  final T data;

  TaskSuccess(this.data);
}
final class TaskError<T> extends TaskState {
  final String error;

  TaskError({required this.error});
}
final class DeleteTaskSuccess<T> extends TaskState {
  final T data;

  DeleteTaskSuccess(this.data);
}

final class DeleteTaskError<T> extends TaskState {
  final String error;

  DeleteTaskError({required this.error});
}

