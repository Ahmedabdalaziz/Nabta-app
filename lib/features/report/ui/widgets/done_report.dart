import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:graduation_project/features/home/ui/home_background.dart';

import '../../../../core/routing/routing.dart';
import '../../../../core/theming/color.dart';

class DoneReport extends StatefulWidget {
  const DoneReport({super.key});

  @override
  State<DoneReport> createState() => _DoneReportState();
}

class _DoneReportState extends State<DoneReport> {
  int _currentIndex = 0;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return HomeBackground(
      child: Column(
        children: [
          verticalSpace(50.h),
          Row(
            children: [
              horizontalSpace(15.w),
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: CircleAvatar(
                  backgroundColor: ColorsManager.mainGreen.withOpacity(0.05),
                  radius: 26.r,
                  child: SvgPicture.asset(arrowBack),
                ),
              ),
              horizontalSpace(110.w),
              Text("إبلاغ بيطري",
                  style: CairoTextStyles.bold.copyWith(
                      fontSize: 28.sp, color: ColorsManager.mainGreen)),
              verticalSpace(50.h),
            ],
          ),
          verticalSpace(20.h),
          Column(
            children: [
              SvgPicture.asset("assets/SVGs/home/reportSending.svg"),
              Center(
                child: SizedBox(
                  width: 400.w,
                  height: 60.h,
                  child: DarkCustomTextButton(
                    textStyle: CairoTextStyles.extraBold
                        .copyWith(color: ColorsManager.white, fontSize: 26.sp),
                    text: "العودة للرئيسية",
                    onPressed: () {
                      context.pushNamedAndRemoveUntil(Routing.homeScreen);
                    },
                    bottomColor: ColorsManager.mainGreen,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
