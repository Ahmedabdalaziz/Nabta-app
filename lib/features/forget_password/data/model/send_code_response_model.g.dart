// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_code_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendResponseModel _$SendResponseModelFromJson(Map<String, dynamic> json) =>
    SendResponseModel(
      message: json['message'] as String,
      success: json['success'] as String,
    );

Map<String, dynamic> _$SendResponseModelToJson(SendResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
    };
