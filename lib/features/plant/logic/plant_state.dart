part of 'plant_cubit.dart';

@immutable
sealed class PlantState {}

final class PlantInitial extends PlantState {}

final class PlantFailed extends PlantState {
  final String errorMessage;

  PlantFailed(this.errorMessage);

}

final class PlantSuccess extends PlantState {

  final PlantResponse plantResponse;

  PlantSuccess(this.plantResponse);

}

final class plantLoading extends PlantState {}