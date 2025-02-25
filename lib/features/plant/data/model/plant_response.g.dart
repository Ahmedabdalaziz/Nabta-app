// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantResponse _$PlantResponseFromJson(Map<String, dynamic> json) =>
    PlantResponse(
      success: json['success'] as bool?,
      count: (json['count'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlantResponseToJson(PlantResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      sId: json['sId'] as String?,
      name: json['name'] as String?,
      soilType: json['soilType'] as String?,
      lightRequirements: json['lightRequirements'] as String?,
      waterRequirements: json['waterRequirements'] as String?,
      season: json['season'] as String?,
      growthDuration: json['growthDuration'] as String?,
      spacing: json['spacing'] as String?,
      humidityRequirements: json['humidityRequirements'] as String?,
      purpose: json['purpose'] as String?,
      plantingMethod: json['plantingMethod'] as String?,
      commonDiseases: (json['commonDiseases'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      preventionMethods: (json['preventionMethods'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      fertilizers: json['fertilizers'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'sId': instance.sId,
      'name': instance.name,
      'soilType': instance.soilType,
      'lightRequirements': instance.lightRequirements,
      'waterRequirements': instance.waterRequirements,
      'season': instance.season,
      'growthDuration': instance.growthDuration,
      'spacing': instance.spacing,
      'humidityRequirements': instance.humidityRequirements,
      'purpose': instance.purpose,
      'plantingMethod': instance.plantingMethod,
      'commonDiseases': instance.commonDiseases,
      'preventionMethods': instance.preventionMethods,
      'fertilizers': instance.fertilizers,
      'images': instance.images,
      'description': instance.description,
      'category': instance.category,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      url: json['url'] as String?,
      sId: json['sId'] as String?,
    );

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'url': instance.url,
      'sId': instance.sId,
    };
