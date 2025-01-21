class WeatherRequest {
  final String location;
  final String startDate;
  final String endDate;

  WeatherRequest({
    required this.location,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}