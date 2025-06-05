// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailCheckRequestModel _$EmailCheckRequestModelFromJson(
        Map<String, dynamic> json) =>
    EmailCheckRequestModel(
      email: json['email'] as String,
    );

Map<String, dynamic> _$EmailCheckRequestModelToJson(
        EmailCheckRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

EmailCheckResponseModel _$EmailCheckResponseModelFromJson(
        Map<String, dynamic> json) =>
    EmailCheckResponseModel(
      json['message'] as String,
    );

Map<String, dynamic> _$EmailCheckResponseModelToJson(
        EmailCheckResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
