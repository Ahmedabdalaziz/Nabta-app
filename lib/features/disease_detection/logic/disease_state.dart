part of 'disease_cubit.dart';

@immutable
sealed class DiseaseState {}

final class DiseaseInitial extends DiseaseState {}

final class DiseaseSuccess extends DiseaseState {
  final PlantDiseaseDetectionResponseModel response;

  DiseaseSuccess(this.response);
}

final class DiseaseLoading extends DiseaseState {}
final class DiseaseDataCached extends DiseaseState {}

final class DiseaseFailure extends DiseaseState {
  final String message;

  DiseaseFailure({required this.message});
}
