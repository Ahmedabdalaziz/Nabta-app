// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sigin_model_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigInModelRequest _$SigInModelRequestFromJson(Map<String, dynamic> json) =>
    SigInModelRequest(
      username: json['username'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      city: json['city'] as String,
      gender: json['gender'] as String,
      ProfileImage: json['ProfileImage'] as String?,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$SigInModelRequestToJson(SigInModelRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'birthDate': instance.birthDate.toIso8601String(),
      'city': instance.city,
      'gender': instance.gender,
      'ProfileImage': instance.ProfileImage,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
    };
