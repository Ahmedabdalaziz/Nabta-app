part of 'send_forget_password_cubit.dart';

@immutable
sealed class SendForgetPasswordState {}

final class SendForgetPasswordInitial extends SendForgetPasswordState {}

class SendForgetPasswordLoading extends SendForgetPasswordState {}

class SendForgetPasswordSuccess extends SendForgetPasswordState {
  final String message;

  SendForgetPasswordSuccess({required this.message});
}

class SendForgetPasswordFailure extends SendForgetPasswordState {
  final String errorMessage;

  SendForgetPasswordFailure({required this.errorMessage});
}

class ValidationError extends SendForgetPasswordState {
  final String message;

  ValidationError(this.message);
}
