import 'package:json_annotation/json_annotation.dart';

part 'sigin_model_response.g.dart';

@JsonSerializable()
class SignInResponseModel {
  final String status;
  final String message;

  SignInResponseModel({required this.status, required this.message});

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseModelToJson(this);
}
