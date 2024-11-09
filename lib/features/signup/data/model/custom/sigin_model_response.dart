import 'package:json_annotation/json_annotation.dart';

part 'sigin_model_response.g.dart';

@JsonSerializable()
class SignInResponse {
  final String token;

  SignInResponse({required this.token});

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}
