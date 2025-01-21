import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/weather/data/models/weather_response.dart';
import 'package:graduation_project/features/weather/data/repo/weather_repo.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit(this.weatherRepository) : super(WeatherInitial());

  Future<void> fetchWeather(String location) async {
    emit(WeatherLoading());
    try {
      final weatherResponse = await weatherRepository.getWeather(location);
      emit(WeatherLoaded(weatherResponse));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}