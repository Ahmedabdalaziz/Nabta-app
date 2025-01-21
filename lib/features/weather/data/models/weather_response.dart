import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  final List<WeatherDay> days;

  WeatherResponse({required this.days});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}

@JsonSerializable()
class WeatherDay {
  final String datetime;
  final double tempmax;
  final double tempmin;
  final double temp;
  final double humidity;
  final double windspeed;
  final String conditions;

  WeatherDay({
    required this.datetime,
    required this.tempmax,
    required this.tempmin,
    required this.temp,
    required this.humidity,
    required this.windspeed,
    required this.conditions,
  });

  factory WeatherDay.fromJson(Map<String, dynamic> json) =>
      _$WeatherDayFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDayToJson(this);
}