part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileLoading<T> extends ProfileState {}

final class ProfileSuccess<T> extends ProfileState {
  final T data;

  ProfileSuccess(this.data);
}

final class ProfileError<T> extends ProfileState {
  final String error;

  ProfileError({required this.error});
}
