/*import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'animal_response.g.dart';

@JsonSerializable()
class AnimalResponse {
List<Animal>? data;

AnimalResponse({this.data});

factory AnimalResponse.fromJson(Map<String, dynamic> json) =>
_$AnimalResponseFromJson(json);

Map<String, dynamic> toJson() => _$AnimalResponseToJson(this);
}

@JsonSerializable()
class Animal {
LifeCycle? lifeCycle;
String? id;
String? scientificName;
String? commonName;
List<String>? image;
String? waterNeeds;
String? foodNeeds;
String? age;
String? description;
Nutrition? nutrition;
Health? health;
Care? care;
Behavior? behavior;
Production? production;
AdditionalInfo? additionalInfo;
String? animalType;
String? createdAt;
String? updatedAt;
int? v;

Animal({
this.lifeCycle,
this.id,
this.scientificName,
this.commonName,
this.image,
this.waterNeeds,
this.foodNeeds,
this.age,
this.description,
this.nutrition,
this.health,
this.care,
this.behavior,
this.production,
this.additionalInfo,
this.animalType,
this.createdAt,
this.updatedAt,
this.v,
});

factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);

Map<String, dynamic> toJson() => _$AnimalToJson(this);
}

@JsonSerializable()
class LifeCycle {
String? averageLifespan;
String? sexualMaturityAge;
String? gestationPeriod;
List<String>? offspringPerBirth;

LifeCycle({
this.averageLifespan,
this.sexualMaturityAge,
this.gestationPeriod,
this.offspringPerBirth,
});

factory LifeCycle.fromJson(Map<String, dynamic> json) =>
_$LifeCycleFromJson(json);

Map<String, dynamic> toJson() => _$LifeCycleToJson(this);
}

@JsonSerializable()
class Nutrition {
String? dietType;
List<String>? suitableFeeds;
List<String>? dailyFoodIntake;
List<String>? dailyWaterNeeds;
List<String>? forbiddenFoods;
String? id;

Nutrition({
this.dietType,
this.suitableFeeds,
this.dailyFoodIntake,
this.dailyWaterNeeds,
this.forbiddenFoods,
this.id,
});

factory Nutrition.fromJson(Map<String, dynamic> json) =>
_$NutritionFromJson(json);

Map<String, dynamic> toJson() => _$NutritionToJson(this);
}

@JsonSerializable()
class Health {
List<String>? nameArabic;
String? symptoms;
String? treatment;
String? prevention;
String? id;

Health({
this.nameArabic,
this.symptoms,
this.treatment,
this.prevention,
this.id,
});

factory Health.fromJson(Map<String, dynamic> json) => _$HealthFromJson(json);

Map<String, dynamic> toJson() => _$HealthToJson(this);
}

@JsonSerializable()
class Care {
List<String>? environment;
String? hygiene;
String? emergencyCases;
List<String>? vaccinationSchedule;
String? id;

Care({
this.environment,
this.hygiene,
this.emergencyCases,
this.vaccinationSchedule,
this.id,
});

factory Care.fromJson(Map<String, dynamic> json) => _$CareFromJson(json);

Map<String, dynamic> toJson() => _$CareToJson(this);
}

@JsonSerializable()
class Behavior {
String? nature;
String? handlingGuidelines;
List<String>? comfortSigns;
List<String>? stressSigns;
String? id;

Behavior({
this.nature,
this.handlingGuidelines,
this.comfortSigns,
this.stressSigns,
this.id,
});

factory Behavior.fromJson(Map<String, dynamic> json) =>
_$BehaviorFromJson(json);

Map<String, dynamic> toJson() => _$BehaviorToJson(this);
}

@JsonSerializable()
class Production {
List<String>? benefits;
List<String>? optimizationMethods;
String? id;

Production({
this.benefits,
this.optimizationMethods,
this.id,
});

factory Production.fromJson(Map<String, dynamic> json) =>
_$ProductionFromJson(json);

Map<String, dynamic> toJson() => _$ProductionToJson(this);
}

@JsonSerializable()
class AdditionalInfo {
String? expertTips;
List<String>? interestingFacts;
String? id;

AdditionalInfo({
this.expertTips,
this.interestingFacts,
this.id,
});

factory AdditionalInfo.fromJson(Map<String, dynamic> json) =>
_$AdditionalInfoFromJson(json);

Map<String, dynamic> toJson() => _$AdditionalInfoToJson(this);
}
*/