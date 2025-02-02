import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/functions.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class WeatherCard extends StatelessWidget {
  final String condition; // حالة الطقس (صافي، ممطر، غائم، إلخ)
  final double humidity; // الرطوبة
  final double windSpeed; // سرعة الرياح
  final double temperature; // درجة الحرارة
  final String location; // الموقع

  const WeatherCard({
    super.key,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.temperature,
    required this.location,
  });

  // دالة لتحديد الصورة بناءً على حالة الطقس
  String _getImagePath() {
    switch (condition) {
      case 'clear':
      case 'Cold':
        return 'assets/SVGs/home/weather2.png';
      case 'cloudy':
      case 'Partially cloudy':
      case 'Fog':
      case 'Mist':
      case 'overcast':
        return 'assets/SVGs/home/1.5Group 127.png';
      case 'rain':
      case 'Heavy Rain':
      case 'Light Rain':
      case 'drizzle':
        return 'assets/SVGs/home/weather3.png';
      case 'Sandstorm':
      case 'Duststorm':
      case 'Thunderstorm':
      case 'Windy':
        return 'assets/SVGs/home/Group 130.png';
      default:
        return 'assets/SVGs/home/Group 129.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = _getImagePath();
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(imagePath, fit: BoxFit.fitWidth),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12.64.h, right: 7.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    translatedCondition(condition),
                    style: CairoTextStyles.bold.copyWith(
                      fontSize: 13.sp,
                      color: ColorsManager.secondGreen,
                    ),
                  ),
                  Text(
                    'الامطار : %0',
                    style: CairoTextStyles.bold.copyWith(
                      fontSize: 13.sp,
                      color: ColorsManager.secondGreen,
                    ),
                  ),
                  Text(
                    'الرطوبة : % ${humidity.toStringAsFixed(0)}',
                    style: CairoTextStyles.bold.copyWith(
                      fontSize: 13.sp,
                      color: ColorsManager.secondGreen,
                    ),
                  ),
                  Text(
                    'الرياح : ${windSpeed.toStringAsFixed(0)} كم/س',
                    style: CairoTextStyles.bold.copyWith(
                      fontSize: 13.sp,
                      color: ColorsManager.secondGreen,
                    ),
                  ),
                ],
              ),
            ),
            horizontalSpace(8.5.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${temperature.toStringAsFixed(0)}\u00B0',
                  style: CairoTextStyles.bold.copyWith(
                    fontSize: 65.sp,
                    color: ColorsManager.mainGreen,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 0,
                        right: 15.w,
                        left: 0,
                        bottom: 3.h,
                      ),
                      child: Text(
                        location,
                        style: CairoTextStyles.bold.copyWith(
                          fontSize: 16.sp,
                          color: ColorsManager.mainGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}