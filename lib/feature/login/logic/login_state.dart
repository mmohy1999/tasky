part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading<T> extends LoginState {}

final class LoginSuccess<T> extends LoginState {
  final T data;

  LoginSuccess(this.data);
}

final class LoginError<T> extends LoginState {
  final String error;

  LoginError({required this.error});
}