import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'sigin_model_request.g.dart';

@JsonSerializable()
class SigInModelRequest {
  final String username;
  final String birthDate;
  final String city;
  final String gender;
  final String? ProfileImage;
  final String email;
  final String password;
  final String phone;

  SigInModelRequest({
    required this.username,
    required this.birthDate,
    required this.city,
    required this.gender,
    this.ProfileImage,
    required this.email,
    required this.password,
    required this.phone,
  });

  factory SigInModelRequest.fromJson(Map<String, dynamic> json) =>
      _$SigInModelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SigInModelRequestToJson(this);
}
