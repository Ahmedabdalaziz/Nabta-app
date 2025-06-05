import 'package:json_annotation/json_annotation.dart';

part 'email_check.g.dart';

@JsonSerializable()
class EmailCheckRequestModel {
  final String email;

  EmailCheckRequestModel({required this.email});

  Map<String, dynamic> toJson() => _$EmailCheckRequestModelToJson(this);
}

@JsonSerializable()
class EmailCheckResponseModel {
  final String message;

  EmailCheckResponseModel( this.message);
  factory EmailCheckResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EmailCheckResponseModelFromJson(json);
}
