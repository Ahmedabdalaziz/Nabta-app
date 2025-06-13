import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';

import '../../../../core/helper/strings.dart';
import '../../../../core/theming/color.dart';
import '../../../../core/theming/style_manager.dart';

class WelcomeChatScreen extends StatefulWidget {
  const WelcomeChatScreen({super.key});

  @override
  State<WelcomeChatScreen> createState() => _WelcomeChatScreenState();
}

class _WelcomeChatScreenState extends State<WelcomeChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: ColorsManager.white,
      body: Stack(
        children: [
          Image.asset(
            "assets/SVGs/home/مقاس موبايلي (1).png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Column(
            children: [
              verticalSpace(100.h),
              Row(
                children: [
                  horizontalSpace(15.w),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: CircleAvatar(
                      backgroundColor:
                          ColorsManager.mainGreen.withOpacity(0.05),
                      radius: 26.r,
                      child: SvgPicture.asset(arrowBack),
                    ),
                  ),
                  horizontalSpace(145.w),
                  Text(" AI نبتة",
                      style: CairoTextStyles.bold.copyWith(
                          fontSize: 24.sp, color: ColorsManager.mainGreen)),
                ],
              ),
              Image.asset("assets/SVGs/onboarding/1onboarding.png"),
              verticalSpace(24.h),
              SizedBox(
                width: 408.w,
                height: 64.h,
                child: DarkCustomTextButton(
                  bottomColor: ColorsManager.mainGreen,
                  text: " ! ابدأ بسؤالك الآن",
                  textColor: ColorsManager.white,
                  onPressed: () {
                    context.pushNamed(Routing.chatScreen);
                  },
                  textStyle:
                      CairoTextStyles.extraBold.copyWith(fontSize: 20.sp),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
