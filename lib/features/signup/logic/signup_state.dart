part of 'signup_cubit.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String status; // الـ status اللي بيرجعها الباك إند
  final String message; // الرسالة اللي بيرجعها الباك إند

  SignupSuccess(this.status, this.message);
}

class SignupError extends SignupState {
  final String message;

  SignupError(this.message);
}

class SignupUserDetailsUpdated extends SignupState {}

class SignupContactDetailsUpdated extends SignupState {}

class SignupPasswordUpdated extends SignupState {}

class SignupConfirmPasswordUpdated extends SignupState {}

class SignupProfileImageUpdated extends SignupState {}