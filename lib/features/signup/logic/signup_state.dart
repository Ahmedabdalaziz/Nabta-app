part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupError extends SignupState {
  final String message;

  SignupError(this.message);
}

class SignupValidationError extends SignupState {
  final String message;

  SignupValidationError(this.message);
}

class SignupUserDetailsUpdated extends SignupState {}

class SignupContactDetailsUpdated extends SignupState {}

class SignupPasswordUpdated extends SignupState {}

class PasswordValidated extends SignupState {}

class SignupProfileImageUpdated extends SignupState {}
