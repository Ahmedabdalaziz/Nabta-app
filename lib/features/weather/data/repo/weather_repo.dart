import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_project/core/networking/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_response.dart';
import '../remote/weather_api_service.dart';

class WeatherRepository {
  final WeatherApiService weatherApiService;

  WeatherRepository(this.weatherApiService);

  Future<WeatherResponse> getWeather(String location) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final dateFormat = DateFormat('yyyy-MM-dd');
    final today = dateFormat.format(now);

    // اشوف هل احنا جبناها النهاردة ولا لا
    final lastFetchDate = prefs.getString("last_fetch_date");
    if (lastFetchDate == today) {
      final cachedData = prefs.getString("cached_weather_data");
      if (cachedData != null) {
        return WeatherResponse.fromJson(jsonDecode(cachedData));
      }
    }

    final startDate = today;
    final endDate = dateFormat.format(now.add(const Duration(days: 2)));

    try {
      final weatherResponse = await weatherApiService.getWeather(
        location,
        startDate,
        endDate,
        "metric",
        ApiConstants.weatherApiKey,
      );

      // ................................ خزن امعلم ................................
      await prefs.setString("last_fetch_date", today);
      await prefs.setString(
          "cached_weather_data", jsonEncode(weatherResponse.toJson()));

      return weatherResponse;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
