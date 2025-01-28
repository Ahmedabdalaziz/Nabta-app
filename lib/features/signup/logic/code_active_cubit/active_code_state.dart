part of 'active_code_cubit.dart';

@immutable
sealed class ActiveCodeState {}

final class ActiveCodeInitial extends ActiveCodeState {}

final class ActiveCodeLoading extends ActiveCodeState {}

final class ActiveCodeSuccess extends ActiveCodeState {
  final String token;

  ActiveCodeSuccess(this.token);
}

final class ActiveCodeFailure extends ActiveCodeState {
  final String error;

  ActiveCodeFailure(this.error);
}