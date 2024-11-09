import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:graduation_project/core/widgets/indecator.dart';
import 'package:graduation_project/features/signup/ui/signup_screen.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/helper/strings.dart';
import '../../../core/theming/style_manager.dart';
import '../../../core/widgets/Dark_Custom_text_field.dart';

class SecondSignup extends StatelessWidget {
  const SecondSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupScreen(
      customContent: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "كلمة المرور",
                textAlign: TextAlign.right,
                style: CairoTextStyles.extraBold.copyWith(
                    fontSize: 20.sp, color: ColorsManager.secondGreen),
              ),
              horizontalSpace(32.sp),
            ],
          ),
          verticalSpace(20.sp),
          SizedBox(
            width: 400.w,
            height: 56.h,
            child: DarkCustomTextField(
              textAlign: TextAlign.right,
              labelText: "أدخل كلمة المرور",
              borderCircular: 50.sp,
              controller: null,
              textColor: ColorsManager.white,
            ),
          ),
          verticalSpace(35.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "تأكيد كلمة المرور",
                textAlign: TextAlign.right,
                style: CairoTextStyles.extraBold.copyWith(
                    fontSize: 20.sp, color: ColorsManager.secondGreen),
              ),
              horizontalSpace(32.sp),
            ],
          ),
          verticalSpace(20.sp),
          SizedBox(
            width: 400.w,
            height: 56.h,
            child: DarkCustomTextField(
              textAlign: TextAlign.right,
              labelText: "تأكيد كلمة المرور",
              borderCircular: 50.sp,
              controller: null,
              textColor: ColorsManager.white,
            ),
          ),
          verticalSpace(50.sp),
           SizedBox(
             height: 90.h,
             width: 408.w,
             child: SvgPicture.asset(WarningBoxSvg),
           ),
          verticalSpace(30.sp),
          SizedBox(
            height: 56.h ,
            width: 408.w ,
            child: DarkCustomTextButton(
              text: 'حفظ كلمة المرور',
              textStyle: CairoTextStyles.extraBold
                  .copyWith(fontSize: 20.sp, color: ColorsManager.white),
              onPressed: (){
                context.pushNamed(Routing.passwordConfirmationScreen);
              },
            ),
          ),
          verticalSpace(20.sp),

          SizedBox(
            width: 80.w,
            height: 80.h,
            child: GestureDetector(
              onTap: (){},
              child: CircleProgressBar(
                animationDuration: const Duration(seconds: 1),
                backgroundColor: Colors.grey.shade300,
                foregroundColor: ColorsManager.secondGreen,
                value: 0.50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
