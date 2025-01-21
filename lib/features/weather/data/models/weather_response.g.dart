// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      days: (json['days'] as List<dynamic>)
          .map((e) => WeatherDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'days': instance.days,
    };

WeatherDay _$WeatherDayFromJson(Map<String, dynamic> json) => WeatherDay(
      datetime: json['datetime'] as String,
      tempmax: (json['tempmax'] as num).toDouble(),
      tempmin: (json['tempmin'] as num).toDouble(),
      temp: (json['temp'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
      windspeed: (json['windspeed'] as num).toDouble(),
      conditions: json['conditions'] as String,
    );

Map<String, dynamic> _$WeatherDayToJson(WeatherDay instance) =>
    <String, dynamic>{
      'datetime': instance.datetime,
      'tempmax': instance.tempmax,
      'tempmin': instance.tempmin,
      'temp': instance.temp,
      'humidity': instance.humidity,
      'windspeed': instance.windspeed,
      'conditions': instance.conditions,
    };
