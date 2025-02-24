import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class BackgroundCamera extends StatefulWidget {
  final Widget customWidget;

  const BackgroundCamera({super.key, required this.customWidget});

  @override
  State<BackgroundCamera> createState() => _BackgroundCameraState();
}

class _BackgroundCameraState extends State<BackgroundCamera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/SVGs/home/مقاس موبايلي (1).png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          SafeArea(
              child: Column(
            children: [
              verticalSpace(65.h),
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
                  horizontalSpace(110.w),
                  Text("فحص النباتات",
                      style: CairoTextStyles.bold.copyWith(
                          fontSize: 28.sp, color: ColorsManager.mainGreen)),
                ],
              ),
              verticalSpace(42.h),
              widget.customWidget
            ],
          ))
        ],
      ),
    );
  }
}
