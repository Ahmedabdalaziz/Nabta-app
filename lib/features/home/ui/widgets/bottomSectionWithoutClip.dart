import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class BottomSectionWithouCliprrect extends StatelessWidget {
  final String sectionLabel;
  final String imgPath;
  const BottomSectionWithouCliprrect({
    super.key,
    required this.sectionLabel,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 188.w,
      height: 128.h,
      decoration: BoxDecoration(
        color: const Color(0xffE0EAE4),
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child:  Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Image.asset(imgPath),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 8.h,right: 8.w),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sectionLabel,
                  style: CairoTextStyles.bold.copyWith(fontSize: 16.sp,color: ColorsManager.secondGreen),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
