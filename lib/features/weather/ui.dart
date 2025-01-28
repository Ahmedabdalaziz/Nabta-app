// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation_project/core/ID/dependacy_injection.dart';
// import 'package:graduation_project/features/weather/data/models/weather_response.dart';
// import 'package:graduation_project/features/weather/data/repo/weather_repo.dart';
// import 'package:graduation_project/features/weather/logic/weather_cubit.dart';
//
// import 'package:intl/intl.dart';
//
// class WeatherScreen extends StatelessWidget {
//   final String location;
//
//   WeatherScreen({this.location = 'Cairo'});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather in $location'),
//         centerTitle: true,
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: BlocProvider(
//         create: (context) => WeatherCubit(getIt<WeatherRepository>())..fetchWeather(location),
//         child: BlocBuilder<WeatherCubit, WeatherState>(
//           builder: (context, state) {
//             return switch (state) {
//               WeatherInitial() => _buildInitialState(),
//               WeatherLoading() => _buildLoadingState(),
//               WeatherLoaded(:final weatherResponse) => _buildLoadedState(weatherResponse),
//               WeatherError(:final message) => _buildErrorState(message),
//             };
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInitialState() {
//     return const Center(
//       child: Text(
//         "Enter a city name to get the weather!",
//         style: TextStyle(fontSize: 18, color: Colors.grey),
//       ),
//     );
//   }
//
//   Widget _buildLoadingState() {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }
//
//   Widget _buildLoadedState(WeatherResponse weatherResponse) {
//     final days = weatherResponse.days;
//
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: days.length,
//       itemBuilder: (context, index) {
//         final day = days[index];
//         return Card(
//           elevation: 4,
//           margin: const EdgeInsets.only(bottom: 16),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   day.datetime,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   getTempNow(day),
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Humidity: ${day.humidity}%",
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Wind: ${day.windspeed} km/h",
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Conditions: ${day.conditions}",
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildErrorState(String message) {
//     return Center(
//       child: Text(
//         "Error: $message",
//         style: const TextStyle(fontSize: 18, color: Colors.red),
//       ),
//     );
//   }
//
//   String getTempNow(WeatherDay day) {
//     final now = DateTime.now();
//     final hour = int.parse(DateFormat('H').format(now));
//
//     if (hour >= 6 && hour < 18) {
//       return "Max: ${day.tempmax}°C";
//     } else {
//       return "Min: ${day.tempmin}°C";
//     }
//   }
// }