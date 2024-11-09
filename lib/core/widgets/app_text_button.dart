import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/color.dart';

class DarkCustomTextButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color textColor;
  final TextStyle textStyle;
  final Color bottomColor;

  const DarkCustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = ColorsManager.white,
    required this.textStyle,
    this.bottomColor = ColorsManager.secondGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bottomColor,
        borderRadius: BorderRadius.circular(50.sp),
      ),
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(ColorsManager.white),
          padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 22.0.w)),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.sp),
          )),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle.copyWith(color: textColor),
        ),
      ),
    );
  }
}
