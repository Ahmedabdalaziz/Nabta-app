import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/Dark_Custom_text_field.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:graduation_project/features/login/ui/background.dart';
import 'package:graduation_project/features/signup/ui/widget/opt_bottom_sheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Background(
        customContent: Column(
      children: [
        verticalSpace(26.h),
        Container(
          width: 50.w,
          height: 6.sp,
          decoration: BoxDecoration(
            color: ColorsManager.secondGreen,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        verticalSpace(16.h),
        Center(
          child: Text(
            "نسيت كلمة المرور",
            style: CairoTextStyles.extraBold
                .copyWith(fontSize: 30.sp, color: ColorsManager.secondGreen),
          ),
        ),
        verticalSpace(24.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
          child: Center(
            child: Text(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              "الرجاء إدخال البريد الإلكتروني الذي تم تسجيله مسبقًا في حسابك، حتى نتمكن من إرسال الكود التأكيدي لاستعادة الوصول أو التحقق من حسابك .",
              style: CairoTextStyles.bold.copyWith(
                fontSize: 14.sp,
                color: ColorsManager.secondGreen,
                height: 2.3.sp,
              ),
            ),
          ),
        ),
        verticalSpace(38.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "البريد الألكتروني",
              textAlign: TextAlign.right,
              style: CairoTextStyles.extraBold
                  .copyWith(fontSize: 20.sp, color: ColorsManager.secondGreen),
            ),
            horizontalSpace(32.sp),
          ],
        ),
        verticalSpace(12.sp),
        SizedBox(
          width: 400.w,
          height: 56.h,
          child: DarkCustomTextField(
            textAlign: TextAlign.right,
            labelText: "أدخل بريدك الألكتروني",
            borderCircular: 50.sp,
            controller: emailController,
            textColor: ColorsManager.white,
          ),
        ),
        verticalSpace(56.h),
        SizedBox(
          height: 56.h,
          width: 400.w,
          child: DarkCustomTextButton(
            text: 'إعادة تعيين كلمة المرور',
            textStyle: CairoTextStyles.extraBold
                .copyWith(fontSize: 20.sp, color: ColorsManager.white),
            onPressed: () {
              final email = emailController.text;
              showMaterialModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50.sp),
                    ),
                  ),
                  backgroundColor: ColorsManager.white,
                  animationCurve: Curves.easeInOut,
                  context: context,
                  builder: (BuildContext context) {
                    return const OTPBottomSheet();
                  });
            },
          ),
        )
      ],
    ));
  }
}
