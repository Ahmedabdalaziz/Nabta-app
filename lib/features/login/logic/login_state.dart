part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess(this.token);
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}

class ValidationError extends LoginState {
  final String message;

  ValidationError(this.message);
}
