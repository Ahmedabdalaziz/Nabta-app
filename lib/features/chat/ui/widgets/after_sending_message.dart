import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class AfterSendMessage extends StatelessWidget {
  const AfterSendMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(20.h),
        Text(
          " ! أهلاً بك",
          style: CairoTextStyles.black.copyWith(
            fontSize: 28.sp,
            color: ColorsManager.secondGreen,
          ),
        ),
        verticalSpace(20.h),
        Center(
          child: Text(
            " هل تحتاج إلى مساعدة في زراعتك؟ ",
            style: CairoTextStyles.semiBold.copyWith(
              fontSize: 24.sp,
              color: ColorsManager.secondGreen,
            ),
          ),
        ),
        verticalSpace(70.h),
        Image.asset(
          "assets/SVGs/chat/chat_imoji.png",
          width: 200.w,
          height: 260.h,
        ),
      ],
    );
  }
}
