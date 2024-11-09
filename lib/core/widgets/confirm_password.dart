import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/features/signup/ui/signup_screen.dart';

import '../helper/spacing.dart';
import '../routing/routing.dart';
import '../theming/color.dart';
import '../theming/style_manager.dart';
import 'Dark_Custom_text_field.dart';
import 'app_text_button.dart';
import 'indecator.dart';

class PasswordConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupScreen(
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
          verticalSpace(20.sp),
          Row(
            children: [
              SizedBox(
                width: 408.w,
                height: 22.5.h,
                child:Text(
                  "كلمة المرور لا تقل عن 8 أحرف ",
                  textAlign: TextAlign.right,
                  style: CairoTextStyles.bold.copyWith(
                      fontSize: 12.sp, color: ColorsManager.mainGreen),
                ),
              ),
              horizontalSpace(8.sp),
              Container(
                width: 10.sp, // حجم النقطة
                height: 10.sp,
                decoration: const BoxDecoration(
                  color: ColorsManager.mainGreen, // لون النقطة
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
            verticalSpace(8.sp),
            Row(
              children: [
                SizedBox(
                  width: 408.w,
                  height: 22.5.h,
                  child:Text(
                    "كلمة المرور تحتوي على حروف كبيرة وصغيرة ",
                    textAlign: TextAlign.right,
                    style: CairoTextStyles.bold.copyWith(
                        fontSize: 12.sp, color: ColorsManager.mainGreen),
                  ),
                ),
                horizontalSpace(8.sp),
                Container(
                  width: 10.sp, // حجم النقطة
                  height: 10.sp,
                  decoration: const BoxDecoration(
                    color: ColorsManager.mainGreen, // لون النقطة
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            verticalSpace(8.sp),
            Row(
              children: [
                SizedBox(
                  width: 408.w,
                  height: 22.5.h,
                  child:Text(
                    "كلمة المرور تحتوي على أرقام  ",
                    textAlign: TextAlign.right,
                    style: CairoTextStyles.bold.copyWith(
                        fontSize: 12.sp, color: ColorsManager.mainGreen),
                  ),
                ),
                horizontalSpace(8.sp),
                Container(
                  width: 10.sp, // حجم النقطة
                  height: 10.sp,
                  decoration: const BoxDecoration(
                    color: ColorsManager.mainGreen, // لون النقطة
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            verticalSpace(8.sp),
            Row(
              children: [
                SizedBox(
                  width: 408.w,
                  height: 22.5.h,
                  child:Text(
                    "كلمتا المرور متطابقتان  ",
                    textAlign: TextAlign.right,
                    style: CairoTextStyles.bold.copyWith(
                        fontSize: 12.sp, color: ColorsManager.mainGreen),
                  ),
                ),
                horizontalSpace(8.sp),
                Container(
                  width: 10.sp, // حجم النقطة
                  height: 10.sp,
                  decoration: const BoxDecoration(
                    color: ColorsManager.mainGreen, // لون النقطة
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            verticalSpace(20.sp),
            SizedBox(
              height: 56.h ,
              width: 408.w ,
              child: DarkCustomTextButton(
                text: 'حفظ كلمة المرور',
                textStyle: CairoTextStyles.extraBold
                    .copyWith(fontSize: 20.sp, color: ColorsManager.white),
                onPressed: (){
                  context.pushNamed(Routing.uploadingImageScreen);
                },
              ),
            ),
            verticalSpace(35.sp),
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
      ),
    );
  }
}
