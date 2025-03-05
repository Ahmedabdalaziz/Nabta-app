import 'package:json_annotation/json_annotation.dart';

part 'report_response.g.dart';

@JsonSerializable()
class ReportResponseModel {
  final int caseId;
  final String status;

  ReportResponseModel({
    required this.caseId,
    required this.status,
  });

  factory ReportResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReportResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportResponseModelToJson(this);
}
