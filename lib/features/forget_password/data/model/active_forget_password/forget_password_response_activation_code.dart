import 'package:json_annotation/json_annotation.dart';

part 'forget_password_response_activation_code.g.dart';

@JsonSerializable()
class ForgetPasswordResponseActivationCodeModel {
  final String token;

  ForgetPasswordResponseActivationCodeModel(this.token);

  factory ForgetPasswordResponseActivationCodeModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseActivationCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseActivationCodeModelToJson(this);
}