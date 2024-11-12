import 'package:json_annotation/json_annotation.dart';

part 'sigin_model_error.g.dart';

@JsonSerializable()
class SignUpErrorModel {
  final String message;

  SignUpErrorModel(this.message);

  factory SignUpErrorModel.fromJson(Map<String, dynamic> json) => _$SignUpErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpErrorModelToJson(this);
}
