import 'package:json_annotation/json_annotation.dart';

part 'send_code_error_model.g.dart';

@JsonSerializable()
class SendForgetPasswordErrorModel {
  final String message;

  SendForgetPasswordErrorModel(this.message);

  factory SendForgetPasswordErrorModel.fromJson(Map<String, dynamic> json) =>
      _$SendForgetPasswordErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$SendForgetPasswordErrorModelToJson(this);
}
