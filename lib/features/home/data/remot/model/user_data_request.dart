import 'package:json_annotation/json_annotation.dart';

part 'user_data_request.g.dart';

@JsonSerializable()
class UserDataResponse {
  final UserData userData;

  const UserDataResponse({required this.userData});

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);
}

@JsonSerializable()
class UserData {
  @JsonKey(name: '_id')
  final String? sId;
  final String? username;
  final String? phone;
  final String? email;
  final String? gender;
  final String? image;
  final String? city;
  final String? state;
  final String? birthDay;
  final List<String>? plants;

  const UserData({
    this.sId,
    this.username,
    this.phone,
    this.email,
    this.gender,
    this.image,
    this.city,
    this.state,
    this.birthDay,
    this.plants,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
