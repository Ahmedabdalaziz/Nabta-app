import 'package:json_annotation/json_annotation.dart';

part 'sign_error_activation_code.g.dart';

@JsonSerializable()
class ActiveCodeErrorModel {
  final String message;

  ActiveCodeErrorModel(this.message);

  factory ActiveCodeErrorModel.fromJson(Map<String, dynamic> json) => _$ActiveCodeErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveCodeErrorModelToJson(this);
}
