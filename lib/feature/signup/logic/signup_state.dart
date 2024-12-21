part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading<T> extends SignupState {}

final class SignupSuccess<T> extends SignupState {
  final T data;

  SignupSuccess(this.data);
}

final class SignupError<T> extends SignupState {
  final String error;

  SignupError({required this.error});
}