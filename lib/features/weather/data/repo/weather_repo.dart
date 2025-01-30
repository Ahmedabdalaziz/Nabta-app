import 'dart:async';
import 'package:easy_localization/easy_localization.dart';

import '../models/weather_response.dart';
import '../remote/weather_api_service.dart';
import 'package:graduation_project/core/networking/api_constants.dart';

class WeatherRepository {
  final WeatherApiService weatherApiService;

  WeatherRepository(this.weatherApiService);

  Future<WeatherResponse> getWeather(String location) async {
    final now = DateTime.now();
    final dateForamt = DateFormat('yyyy-MM-dd');

    final startDate = dateForamt.format(now);
    final endDate = dateForamt.format(now.add(const Duration(days: 2)));
    // simple debug
    print("Start Date: $startDate");
    print("End Date: $endDate");

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
