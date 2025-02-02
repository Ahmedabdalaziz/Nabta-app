import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/color.dart';

Widget customCheckBox({
  required bool isChecked,
  required VoidCallback onTap,
  required double size,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: size.w,
      height: size.h,
      decoration: BoxDecoration(
        color: isChecked ? ColorsManager.mainGreen : Colors.transparent,
        borderRadius: BorderRadius.circular(size * 0.2),
        border: Border.all(color: ColorsManager.mainGreen, width: size * 0.03),
      ),
      child: isChecked
          ? Icon(Icons.check, color: ColorsManager.white, size: size * 0.6)
          : null,
    ),
  );
}
