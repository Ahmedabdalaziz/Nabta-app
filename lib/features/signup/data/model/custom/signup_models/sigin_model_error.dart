import 'package:json_annotation/json_annotation.dart';

part 'sigin_model_error.g.dart';

@JsonSerializable()
class SignUpErrorModel {
  final String message;

  SignUpErrorModel(this.message);

  factory SignUpErrorModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpErrorModelToJson(this);

  // Factory constructor للتعامل مع الـ response
  factory SignUpErrorModel.fromResponse(dynamic response) {
    if (response is Map<String, dynamic>) {
      return SignUpErrorModel.fromJson(response);
    }
    throw FormatException("Invalid response type");
  }
}