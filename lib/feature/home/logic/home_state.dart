part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeSuccess<T> extends HomeState {
  final List<Task> data;

  HomeSuccess(this.data);
}
final class HomeError<T> extends HomeState {
  final String error;

  HomeError({required this.error});
}
final class HomeLogout extends HomeState {}

final class HomeChangeFilter extends HomeState {}
final class HomeSelectTask<String> extends HomeState {
  final String id;

  HomeSelectTask(this.id);
}