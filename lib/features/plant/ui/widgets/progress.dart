import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class InfoProgress extends StatelessWidget {
  final String title;
  final String stringDegree;
  final double degree;
  final String icon;

  const InfoProgress({
    super.key,
    required this.title,
    required this.stringDegree,
    required this.degree,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: CairoTextStyles.extraBold
              .copyWith(fontSize: 18.sp, color: ColorsManager.secondGreen),
        ),
        verticalSpace(25.h),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              icon,
              height: 40.r,
              width: 40.r,
            ),
            SimpleCircularProgressBar(
              size: 70.r,
              progressStrokeWidth: 7.sp,
              valueNotifier: ValueNotifier(degree),
              progressColors: [
                ColorsManager.mainGreen,
                ColorsManager.secondGreen
              ],
              backStrokeWidth: 8.sp,
              backColor: ColorsManager.grey.withOpacity(0.3),
              animationDuration: 3,
              mergeMode: true,
            ),
          ],
        ),
        verticalSpace(20.h),
        Text(
          stringDegree,
          style: CairoTextStyles.bold
              .copyWith(fontSize: 18.sp, color: ColorsManager.mainGreen),
        ),
      ],
    );
  }
}
