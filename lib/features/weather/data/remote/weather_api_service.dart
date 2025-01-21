import 'package:dio/dio.dart';
import 'package:graduation_project/core/networking/api_constants.dart';
import 'package:retrofit/retrofit.dart';

import '../models/weather_response.dart';

part 'weather_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.weatherApiUrl)
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio, {String baseUrl}) = _WeatherApiService;

  @GET("{location}/{startDate}/{endDate}")
  Future<WeatherResponse> getWeather(
    @Path("location") String location,
    @Path("startDate") String startDate,
    @Path("endDate") String endDate,
    @Query("unitGroup") String unitGroup,
    @Query("key") String apiKey,
  );
}
