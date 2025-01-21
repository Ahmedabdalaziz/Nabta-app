part of 'weather_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final WeatherResponse weatherResponse;

  WeatherLoaded(this.weatherResponse);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WeatherLoaded && other.weatherResponse == weatherResponse;
  }

  @override
  int get hashCode => weatherResponse.hashCode;
}

final class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WeatherError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
