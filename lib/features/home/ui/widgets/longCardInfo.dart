import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class LongCardInfo extends StatelessWidget {
  final String cardLabel;
  final String cardHint;
  final String cardDescription;

  const LongCardInfo({
    super.key,
    required this.cardLabel,
    required this.cardHint,
    required this.cardDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                cardLabel,
                style: CairoTextStyles.bold.copyWith(
                    fontSize: 16.sp, color: ColorsManager.secondGreen),
              ),
              verticalSpace(8.h),
              Text(
                cardHint,
                style: CairoTextStyles.bold.copyWith(
                    fontSize: 12.sp, color: ColorsManager.secondGreen),
              ),
              verticalSpace(4.h),
              SizedBox(
                width: 233.w,
                height: 36.h,
                child: Text(
                  cardDescription,
                  style: CairoTextStyles.semiBold.copyWith(
                      fontSize: 12.sp, color: ColorsManager.secondGreen),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
