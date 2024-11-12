import 'package:json_annotation/json_annotation.dart';

part 'sigin_model_response.g.dart';

@JsonSerializable()
class SignInResponseModel {
  final String token;

  SignInResponseModel({required this.token});

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseModelToJson(this);
}
