// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_request_activation_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordRequestActivationCodeModel
    _$ForgetPasswordRequestActivationCodeModelFromJson(
            Map<String, dynamic> json) =>
        ForgetPasswordRequestActivationCodeModel(
          email: json['email'] as String,
          activationCode: json['activationCode'] as String,
        );

Map<String, dynamic> _$ForgetPasswordRequestActivationCodeModelToJson(
        ForgetPasswordRequestActivationCodeModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'activationCode': instance.activationCode,
    };
