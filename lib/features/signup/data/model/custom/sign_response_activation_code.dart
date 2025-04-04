import 'package:json_annotation/json_annotation.dart';

part 'sign_response_activation_code.g.dart';

@JsonSerializable()
class ActivateAccountResponseModel {
  final String token;

  ActivateAccountResponseModel(this.token);

  factory ActivateAccountResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ActivateAccountResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivateAccountResponseModelToJson(this);
}