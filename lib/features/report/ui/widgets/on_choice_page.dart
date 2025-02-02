import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnChoicePage extends StatelessWidget {
  final PageController pageController;
  final bool isCaseDetails;
  final bool isContactAndLocation;

  const OnChoicePage({
    super.key,
    required this.pageController,
    required this.isCaseDetails,
    required this.isContactAndLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(10.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "التواصل و الموقع",
              style: CairoTextStyles.bold.copyWith(
                fontSize: 20.sp,
                color: isContactAndLocation
                    ? ColorsManager.mainGreen
                    : ColorsManager.secondGreen,
              ),
            ),
            horizontalSpace(30.w),
            Text(
              '●',
              style: CairoTextStyles.bold.copyWith(
                fontSize: 22.sp,
                color: ColorsManager.secondGreen,
              ),
            ),
            horizontalSpace(30.w),
            Text(
              "تفاصيل الحالة",
              style: CairoTextStyles.bold.copyWith(
                fontSize: 20.sp,
                color: isCaseDetails
                    ? ColorsManager.mainGreen
                    : ColorsManager.secondGreen,
              ),
            ),
          ],
        ),
        verticalSpace(10.h),
        isCaseDetails
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 90.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SmoothPageIndicator(
                      controller: pageController,
                      count: 1,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8.h,
                        dotWidth: 16.w,
                        activeDotColor: ColorsManager.mainGreen,
                        dotColor: ColorsManager.secondGreen,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        isContactAndLocation
            ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SmoothPageIndicator(
                controller: pageController,
                count: 1,
                effect: ExpandingDotsEffect(
                  dotHeight: 8.h,
                  dotWidth: 16.w,
                  activeDotColor: ColorsManager.mainGreen,
                  dotColor: ColorsManager.secondGreen,
                ),
              ),
            ],
          ),
        )
            : const SizedBox.shrink(),
      ],
    );
  }
}
