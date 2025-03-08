import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class GuideLinesCards extends StatelessWidget {
  final String label;
  final String iconImage;
  final String description;
  final bool isRed;

  const GuideLinesCards({
    super.key,
    required this.label,
    required this.iconImage,
    required this.description,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 408.w,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isRed
            ? ColorsManager.red.withOpacity(0.2)
            : ColorsManager.mainGreen.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25.r),

      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Label
                Text(
                  label,
                  style: CairoTextStyles.bold.copyWith(
                    fontSize: 16.sp,
                    color: ColorsManager.secondGreen,
                  ),
                ),
                verticalSpace(8.h),
                Text(
                  description,
                  style: CairoTextStyles.semiBold.copyWith(
                    fontSize: 16.sp,
                    color: ColorsManager.secondGreen,
                  ),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                  softWrap: true,
                ),
              ],
            ),
          ),
          horizontalSpace(10.w),
          SizedBox(
            height: 48.h,
            width: 48.w,
            child: Image.asset(iconImage),
          ),
        ],
      ),
    );
  }
}
