import 'package:json_annotation/json_annotation.dart';

part 'plant_response.g.dart';

@JsonSerializable()
class PlantResponse {
  bool? success;
  int? count;
  List<Data>? data;


  PlantResponse({this.success, this.count, this.data});

  factory PlantResponse.fromJson(Map<String, dynamic> json) => _$PlantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlantResponseToJson(this);
}

@JsonSerializable()
class Data {
  String? sId;
  String? name;
  String? soilType;
  String? lightRequirements;
  String? waterRequirements;
  String? season;
  String? growthDuration;
  String? spacing;
  String? humidityRequirements;
  String? purpose;
  String? plantingMethod;
  List<String>? commonDiseases;
  List<String>? preventionMethods;
  String? fertilizers;
  List<Images>? images;
  String? description;
  String? category;

  Data({
    this.sId,
    this.name,
    this.soilType,
    this.lightRequirements,
    this.waterRequirements,
    this.season,
    this.growthDuration,
    this.spacing,
    this.humidityRequirements,
    this.purpose,
    this.plantingMethod,
    this.commonDiseases,
    this.preventionMethods,
    this.fertilizers,
    this.images,
    this.description,
    this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Images {
  String? url;
  String? sId;
  Images({this.url, this.sId});

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}