import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';

class Background extends StatelessWidget {
  final Widget customContent;

  const Background({super.key, required this.customContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainGreen,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Transform.translate(
                offset: Offset(0, 30.h),
                child: SvgPicture.asset(
                  loginSVG,
                  height: 250.35.h,
                  width: 180.55.w,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 707.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50.sp),
                  topLeft: Radius.circular(50.sp),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0.sp,
                    bottom: 0.sp,
                    child: SvgPicture.asset(
                      width: 300.w,
                      height: 400.h,
                      "assets/SVGs/login_screen/Plant Background.svg",
                    ),
                  ),
                  Column(
                    children: [customContent, verticalSpace(10.h)],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
