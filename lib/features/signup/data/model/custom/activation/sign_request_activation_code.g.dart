// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_request_activation_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivateAccountRequestModel _$ActivateAccountRequestModelFromJson(
        Map<String, dynamic> json) =>
    ActivateAccountRequestModel(
      email: json['email'] as String,
      activationCode: json['activationCode'] as String,
    );

Map<String, dynamic> _$ActivateAccountRequestModelToJson(
        ActivateAccountRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'activationCode': instance.activationCode,
    };
