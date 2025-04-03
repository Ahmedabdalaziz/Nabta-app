// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_disease_detection_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantDiseaseDetectionRequestModel _$PlantDiseaseDetectionRequestModelFromJson(
        Map<String, dynamic> json) =>
    PlantDiseaseDetectionRequestModel(
      plantType: json['plantType'] as String,
      imageBase64: json['imageBase64'] as String,
    );

Map<String, dynamic> _$PlantDiseaseDetectionRequestModelToJson(
        PlantDiseaseDetectionRequestModel instance) =>
    <String, dynamic>{
      'plantType': instance.plantType,
      'imageBase64': instance.imageBase64,
    };

PlantDiseaseDetectionResponseModel _$PlantDiseaseDetectionResponseModelFromJson(
        Map<String, dynamic> json) =>
    PlantDiseaseDetectionResponseModel(
      accuracy: json['accuracy'] as String,
      description: json['description'] as String,
      lifeCycle: json['lifeCycle'] as String,
      name: json['name'] as String,
      riskPercentage: json['riskPercentage'] as String,
      scientificName: json['scientificName'] as String,
      treatment: json['treatment'] as String,
    );

Map<String, dynamic> _$PlantDiseaseDetectionResponseModelToJson(
        PlantDiseaseDetectionResponseModel instance) =>
    <String, dynamic>{
      'accuracy': instance.accuracy,
      'description': instance.description,
      'lifeCycle': instance.lifeCycle,
      'name': instance.name,
      'riskPercentage': instance.riskPercentage,
      'scientificName': instance.scientificName,
      'treatment': instance.treatment,
    };

PlantDiseaseDetectionErrorModel _$PlantDiseaseDetectionErrorModelFromJson(
        Map<String, dynamic> json) =>
    PlantDiseaseDetectionErrorModel(
      json['message'] as String,
    );

Map<String, dynamic> _$PlantDiseaseDetectionErrorModelToJson(
        PlantDiseaseDetectionErrorModel instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
