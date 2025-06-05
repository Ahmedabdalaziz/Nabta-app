import 'package:json_annotation/json_annotation.dart';

part 'sign_request_activation_code.g.dart';

@JsonSerializable()
class ActivateAccountRequestModel {
  final String email;
  final String activationCode;

  ActivateAccountRequestModel({
    required this.email,
    required this.activationCode,
  });

  factory ActivateAccountRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ActivateAccountRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivateAccountRequestModelToJson(this);
}