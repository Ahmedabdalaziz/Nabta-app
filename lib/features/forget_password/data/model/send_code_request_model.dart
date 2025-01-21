import 'package:json_annotation/json_annotation.dart';

part 'send_code_request_model.g.dart';

@JsonSerializable()
class SendRequestModel {
  final String email;

  SendRequestModel({required this.email});

  Map<String, dynamic> toJson() => _$SendRequestModelToJson(this);
}
