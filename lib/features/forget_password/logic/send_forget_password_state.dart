part of 'send_forget_password_cubit.dart';

@immutable
sealed class SendForgetPasswordState {}

final class SendForgetPasswordInitial extends SendForgetPasswordState {}

final class SendForgetPasswordLoading extends SendForgetPasswordState {}

final class SendForgetPasswordSuccess extends SendForgetPasswordState {
  final String message;

  SendForgetPasswordSuccess({required this.message});
}

final class SendForgetPasswordFailure extends SendForgetPasswordState {
  final String errorMessage;

  SendForgetPasswordFailure({required this.errorMessage});
}

final class ValidationError extends SendForgetPasswordState {
  final String message;

  ValidationError({required this.message});
}

final class SendOtpVerificationSuccess extends SendForgetPasswordState {
  final String message;

  SendOtpVerificationSuccess({required this.message});
}

final class SendOtpVerificationFailure extends SendForgetPasswordState {
  final String errorMessage;

  SendOtpVerificationFailure({required this.errorMessage});
}