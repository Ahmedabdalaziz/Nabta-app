import 'package:json_annotation/json_annotation.dart';

part 'send_code_response_model.g.dart';

@JsonSerializable()
class SendForgetPasswordResponseModel {
  final String message;

  SendForgetPasswordResponseModel({required this.message});

  factory SendForgetPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SendForgetPasswordResponseModelFromJson(json);
}
