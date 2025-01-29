import 'package:json_annotation/json_annotation.dart';

part 'forget_password_request_activation_code.g.dart';

@JsonSerializable()
class ForgetPasswordRequestActivationCodeModel {
  final String email;
  final String activationCode;

  ForgetPasswordRequestActivationCodeModel({
    required this.email,
    required this.activationCode,
  });

  factory ForgetPasswordRequestActivationCodeModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordRequestActivationCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestActivationCodeModelToJson(this);
}