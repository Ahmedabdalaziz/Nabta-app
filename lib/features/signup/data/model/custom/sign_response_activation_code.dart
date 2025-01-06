import 'package:json_annotation/json_annotation.dart';

part 'sign_response_activation_code.g.dart';

@JsonSerializable()
class ActivateAccountResponseModel {
  final String message;

  ActivateAccountResponseModel(this.message);

  factory ActivateAccountResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ActivateAccountResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivateAccountResponseModelToJson(this);
}