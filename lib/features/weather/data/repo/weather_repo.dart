import 'dart:async';
import '../models/weather_response.dart';
import '../remote/weather_api_service.dart';
import 'package:graduation_project/core/networking/api_constants.dart';

class WeatherRepository {
  final WeatherApiService weatherApiService;

  WeatherRepository(this.weatherApiService);

  Future<WeatherResponse> getWeather(String location) async {
    final now = DateTime.now();
    final startDate = "${now.year}-${now.month}-${now.day}";
    final endDate = "${now.year}-${now.month}-${now.day + 2}";

    try {
      final weatherResponse = await weatherApiService.getWeather(
        location,
        startDate,
        endDate,
        "metric",
        ApiConstants.weatherApiKey,
      );

      return weatherResponse;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
