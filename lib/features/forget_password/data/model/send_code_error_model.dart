import 'package:json_annotation/json_annotation.dart';

part 'send_code_error_model.g.dart';

@JsonSerializable()
class SendCodeErrorModel {
  final String message;

  SendCodeErrorModel(this.message);

  factory SendCodeErrorModel.fromJson(Map<String, dynamic> json) =>
      _$SendCodeErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$SendCodeErrorModelToJson(this);
}
