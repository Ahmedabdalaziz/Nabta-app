import 'package:json_annotation/json_annotation.dart';

part 'report_error.g.dart';

@JsonSerializable()
class ReportErrorModel {
  final String message;

  ReportErrorModel({required this.message});

  factory ReportErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ReportErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportErrorModelToJson(this);
}
