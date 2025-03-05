// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportResponseModel _$ReportResponseModelFromJson(Map<String, dynamic> json) =>
    ReportResponseModel(
      caseId: (json['caseId'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$ReportResponseModelToJson(
        ReportResponseModel instance) =>
    <String, dynamic>{
      'caseId': instance.caseId,
      'status': instance.status,
    };
