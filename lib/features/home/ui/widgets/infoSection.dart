import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class InfoSection extends StatelessWidget {
  final String imgPath;
  final String cardLabel;
  final double topPadding;
  final double leftPadding;
  const InfoSection({
    super.key,
    required this.imgPath,
    required this.leftPadding,
    required this.topPadding,
    required this.cardLabel

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 120.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          color: const Color(0xffE0EAE4)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: topPadding, left: leftPadding),
            child: ClipRRect(
                borderRadius:
                BorderRadius.circular(20.sp),
                child: Image.asset(
                  imgPath,
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 8.h, right: 8.w),
                    child: Text(
                      cardLabel,
                      style: CairoTextStyles.bold.copyWith(fontSize: 16.sp,color: ColorsManager.secondGreen),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}