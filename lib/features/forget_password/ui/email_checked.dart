import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:graduation_project/features/login/ui/background.dart';

class EmailChecked extends StatelessWidget {
  const EmailChecked({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
        customContent: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpace(80.h),
            Container(
              width: 50.w,
              height: 6.sp,
              decoration: BoxDecoration(
                color: ColorsManager.secondGreen,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
        verticalSpace(16.h),
        Text(
          'تم التحقق من حسابك ',
          style: CairoTextStyles.extraBold
              .copyWith(fontSize: 30.sp, color: ColorsManager.secondGreen),
        ),
        verticalSpace(64.h),
        SizedBox(
          width: 408.w,
          height: 60.h,
          child: SvgPicture.asset('assets/SVGs/password/checked.svg'),
        ),
        verticalSpace(115.h),
        SizedBox(
          width: 220.w,
          height: 146.h,
          child: SvgPicture.asset('assets/SVGs/password/Frame 24.svg'),
        ),
        verticalSpace(87.h),
        SizedBox(
            width: 408.w,
            height: 56.h,
            child: DarkCustomTextButton(
              text: 'تحديث كلمة المرور',
              onPressed: () {},
              textStyle: CairoTextStyles.extraBold
                  .copyWith(fontSize: 20.sp, color: ColorsManager.white),
            )),
      ],
    ));
  }
}
