import 'package:json_annotation/json_annotation.dart';

part 'forget_password_error_activation_code.g.dart';

@JsonSerializable()
class ForgetPasswordErrorActivationCodeModel {
  final String message;

  ForgetPasswordErrorActivationCodeModel(this.message);

  factory ForgetPasswordErrorActivationCodeModel.fromJson(Map<String, dynamic> json) => _$ForgetPasswordErrorActivationCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordErrorActivationCodeModelToJson(this);
}
