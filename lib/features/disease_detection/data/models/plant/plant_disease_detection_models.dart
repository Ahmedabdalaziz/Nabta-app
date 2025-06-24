import 'package:json_annotation/json_annotation.dart';

part 'plant_disease_detection_models.g.dart';

@JsonSerializable()
class PlantDiseaseDetectionResponseModel {
  final String accuracy;
  final String description;
  final String lifeCycle;
  final String name;
  final String riskPercentage;
  final String scientificName;
  final String treatment;

  PlantDiseaseDetectionResponseModel({
    required this.accuracy,
    required this.description,
    required this.lifeCycle,
    required this.name,
    required this.riskPercentage,
    required this.scientificName,
    required this.treatment,
  });

  factory PlantDiseaseDetectionResponseModel.fromJson(
      Map<String, dynamic> json) =>
      _$PlantDiseaseDetectionResponseModelFromJson(json);
}

@JsonSerializable()
class PlantDiseaseDetectionErrorModel {
  final String message;

  PlantDiseaseDetectionErrorModel(this.message);

  factory PlantDiseaseDetectionErrorModel.fromJson(Map<String, dynamic> json) =>
      _$PlantDiseaseDetectionErrorModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PlantDiseaseDetectionErrorModelToJson(this);
}