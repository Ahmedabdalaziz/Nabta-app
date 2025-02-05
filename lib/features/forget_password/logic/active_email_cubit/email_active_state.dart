part of 'email_active_cubit.dart';

@immutable
sealed class EmailActiveState {}

final class EmailActiveInitial extends EmailActiveState {}

final class EmailActiveLoading extends EmailActiveState {}

final class EmailActiveSuccess extends EmailActiveState {
  final String message;

  EmailActiveSuccess(this.message);
}

final class EmailActiveFailure extends EmailActiveState {
  final String error;

  EmailActiveFailure(this.error);
}
