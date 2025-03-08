// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataResponse _$UserDataResponseFromJson(Map<String, dynamic> json) =>
    UserDataResponse(
      userData: UserData.fromJson(json['userData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataResponseToJson(UserDataResponse instance) =>
    <String, dynamic>{
      'userData': instance.userData,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      sId: json['_id'] as String?,
      username: json['username'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      image: json['image'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      birthDay: json['birthDay'] as String?,
      plants:
          (json['plants'] as List<dynamic>?)?.map((e) => e as String).toList(),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      '_id': instance.sId,
      'username': instance.username,
      'phone': instance.phone,
      'email': instance.email,
      'gender': instance.gender,
      'image': instance.image,
      'city': instance.city,
      'state': instance.state,
      'birthDay': instance.birthDay,
      'plants': instance.plants,
      'token': instance.token,
    };
