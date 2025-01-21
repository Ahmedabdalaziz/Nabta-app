import 'package:json_annotation/json_annotation.dart';

part 'send_code_response_model.g.dart';

@JsonSerializable()
class SendResponseModel {
  final String message;
  final String success;

  SendResponseModel({required this.message, required this.success});

  factory SendResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SendResponseModelFromJson(json);
}
