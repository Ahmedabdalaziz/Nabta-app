part of 'user_data_cubit.dart';

@immutable
sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

final class UserDataLoading extends UserDataState {}

final class UserDataSuccess extends UserDataState {
  final UserDataResponse userData;

  UserDataSuccess({required this.userData});
}

final class UserDataError extends UserDataState {
  final String errorMessage;

  UserDataError({required this.errorMessage});
}

final class UserDataStorageSuccess extends UserDataState {
  final UserDataResponse userData;

  UserDataStorageSuccess({required this.userData});
}

final class UserDataStorageError extends UserDataState {
  final String errorMessage;

  UserDataStorageError(this.errorMessage);
}
