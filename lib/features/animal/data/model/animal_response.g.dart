// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalResponse _$AnimalResponseFromJson(Map<String, dynamic> json) =>
    AnimalResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Animal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnimalResponseToJson(AnimalResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Animal _$AnimalFromJson(Map<String, dynamic> json) => Animal(
      lifeCycle: json['lifeCycle'] == null
          ? null
          : LifeCycle.fromJson(json['lifeCycle'] as Map<String, dynamic>),
      id: json['id'] as String?,
      scientificName: json['scientificName'] as String?,
      commonName: json['commonName'] as String?,
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      waterNeeds: json['waterNeeds'] as String?,
      foodNeeds: json['foodNeeds'] as String?,
      age: json['age'] as String?,
      description: json['description'] as String?,
      nutrition: json['nutrition'] == null
          ? null
          : Nutrition.fromJson(json['nutrition'] as Map<String, dynamic>),
      health: json['health'] == null
          ? null
          : Health.fromJson(json['health'] as Map<String, dynamic>),
      care: json['care'] == null
          ? null
          : Care.fromJson(json['care'] as Map<String, dynamic>),
      behavior: json['behavior'] == null
          ? null
          : Behavior.fromJson(json['behavior'] as Map<String, dynamic>),
      production: json['production'] == null
          ? null
          : Production.fromJson(json['production'] as Map<String, dynamic>),
      additionalInfo: json['additionalInfo'] == null
          ? null
          : AdditionalInfo.fromJson(
              json['additionalInfo'] as Map<String, dynamic>),
      animalType: json['animalType'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AnimalToJson(Animal instance) => <String, dynamic>{
      'lifeCycle': instance.lifeCycle,
      'id': instance.id,
      'scientificName': instance.scientificName,
      'commonName': instance.commonName,
      'image': instance.image,
      'waterNeeds': instance.waterNeeds,
      'foodNeeds': instance.foodNeeds,
      'age': instance.age,
      'description': instance.description,
      'nutrition': instance.nutrition,
      'health': instance.health,
      'care': instance.care,
      'behavior': instance.behavior,
      'production': instance.production,
      'additionalInfo': instance.additionalInfo,
      'animalType': instance.animalType,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'v': instance.v,
    };

LifeCycle _$LifeCycleFromJson(Map<String, dynamic> json) => LifeCycle(
      averageLifespan: json['averageLifespan'] as String?,
      sexualMaturityAge: json['sexualMaturityAge'] as String?,
      gestationPeriod: json['gestationPeriod'] as String?,
      offspringPerBirth: (json['offspringPerBirth'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$LifeCycleToJson(LifeCycle instance) => <String, dynamic>{
      'averageLifespan': instance.averageLifespan,
      'sexualMaturityAge': instance.sexualMaturityAge,
      'gestationPeriod': instance.gestationPeriod,
      'offspringPerBirth': instance.offspringPerBirth,
    };

Nutrition _$NutritionFromJson(Map<String, dynamic> json) => Nutrition(
      dietType: json['dietType'] as String?,
      suitableFeeds: (json['suitableFeeds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      dailyFoodIntake: (json['dailyFoodIntake'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      dailyWaterNeeds: (json['dailyWaterNeeds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      forbiddenFoods: (json['forbiddenFoods'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$NutritionToJson(Nutrition instance) => <String, dynamic>{
      'dietType': instance.dietType,
      'suitableFeeds': instance.suitableFeeds,
      'dailyFoodIntake': instance.dailyFoodIntake,
      'dailyWaterNeeds': instance.dailyWaterNeeds,
      'forbiddenFoods': instance.forbiddenFoods,
      'id': instance.id,
    };

Health _$HealthFromJson(Map<String, dynamic> json) => Health(
      nameArabic: (json['nameArabic'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      symptoms: json['symptoms'] as String?,
      treatment: json['treatment'] as String?,
      prevention: json['prevention'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$HealthToJson(Health instance) => <String, dynamic>{
      'nameArabic': instance.nameArabic,
      'symptoms': instance.symptoms,
      'treatment': instance.treatment,
      'prevention': instance.prevention,
      'id': instance.id,
    };

Care _$CareFromJson(Map<String, dynamic> json) => Care(
      environment: (json['environment'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      hygiene: json['hygiene'] as String?,
      emergencyCases: json['emergencyCases'] as String?,
      vaccinationSchedule: (json['vaccinationSchedule'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$CareToJson(Care instance) => <String, dynamic>{
      'environment': instance.environment,
      'hygiene': instance.hygiene,
      'emergencyCases': instance.emergencyCases,
      'vaccinationSchedule': instance.vaccinationSchedule,
      'id': instance.id,
    };

Behavior _$BehaviorFromJson(Map<String, dynamic> json) => Behavior(
      nature: json['nature'] as String?,
      handlingGuidelines: json['handlingGuidelines'] as String?,
      comfortSigns: (json['comfortSigns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      stressSigns: (json['stressSigns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$BehaviorToJson(Behavior instance) => <String, dynamic>{
      'nature': instance.nature,
      'handlingGuidelines': instance.handlingGuidelines,
      'comfortSigns': instance.comfortSigns,
      'stressSigns': instance.stressSigns,
      'id': instance.id,
    };

Production _$ProductionFromJson(Map<String, dynamic> json) => Production(
      benefits: (json['benefits'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      optimizationMethods: (json['optimizationMethods'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ProductionToJson(Production instance) =>
    <String, dynamic>{
      'benefits': instance.benefits,
      'optimizationMethods': instance.optimizationMethods,
      'id': instance.id,
    };

AdditionalInfo _$AdditionalInfoFromJson(Map<String, dynamic> json) =>
    AdditionalInfo(
      expertTips: json['expertTips'] as String?,
      interestingFacts: (json['interestingFacts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$AdditionalInfoToJson(AdditionalInfo instance) =>
    <String, dynamic>{
      'expertTips': instance.expertTips,
      'interestingFacts': instance.interestingFacts,
      'id': instance.id,
    };
