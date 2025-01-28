import 'package:json_annotation/json_annotation.dart';

part 'send_code_request_model.g.dart';

@JsonSerializable()
class SendForgetPasswordRequestModel {
  final String email;

  SendForgetPasswordRequestModel({required this.email});

  Map<String, dynamic> toJson() => _$SendForgetPasswordRequestModelToJson(this);
}
