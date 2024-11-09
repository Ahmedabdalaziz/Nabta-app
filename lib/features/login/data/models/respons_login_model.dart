import 'package:json_annotation/json_annotation.dart';

part 'respons_login_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final String message;
  final String token;

  LoginResponseModel({required this.message, required this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}
