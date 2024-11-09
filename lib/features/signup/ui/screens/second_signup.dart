import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/Dark_Custom_text_field.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:graduation_project/core/widgets/indecator.dart';
import 'package:graduation_project/features/signup/ui/widget/opt_bottom_sheet.dart';
import 'package:graduation_project/features/signup/ui/widget/signup_screen.dart';

class SecondSignup extends StatefulWidget {
  const SecondSignup({super.key});

  @override
  State<SecondSignup> createState() => _SecondSignupState();
}

class _SecondSignupState extends State<SecondSignup> {
  bool isEmailEmpty = false;

  bool isPhoneEmpty = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void validateAndProceed() {
    setState(() {
      isEmailEmpty = emailController.text.isEmpty;
      isPhoneEmpty = phoneController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SignupScreen(
      customContent: Column(
        children: [
          verticalSpace(38.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "البريد الألكتروني",
                textAlign: TextAlign.right,
                style: CairoTextStyles.extraBold.copyWith(
                    fontSize: 20.sp, color: ColorsManager.secondGreen),
              ),
              horizontalSpace(32.sp),
            ],
          ),
          verticalSpace(12.sp),
          SizedBox(
            width: 400.w,
            height: 56.h,
            child: DarkCustomTextField(
              showError: isEmailEmpty,
              labelText: "أدخل بريدك الألكتروني",
              borderCircular: 50.sp,
              controller: emailController,
              textColor: ColorsManager.white,
            ),
          ),
          verticalSpace(28.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "رقم الهاتف",
                textAlign: TextAlign.left,
                style: CairoTextStyles.extraBold.copyWith(
                    fontSize: 20.sp, color: ColorsManager.secondGreen),
              ),
              horizontalSpace(32.sp),
            ],
          ),
          verticalSpace(12.sp),
          SizedBox(
            width: 400.w,
            height: 56.h,
            child: DarkCustomTextField(
              showError: isPhoneEmpty,
              keyboardType: TextInputType.number,
              labelText: "ادخل رقم الهاتف",
              borderCircular: 50.sp,
              controller: phoneController,
              textColor: ColorsManager.grey,
            ),
          ),
          verticalSpace(64.sp),
          SizedBox(
            height: 56.h,
            width: 400.w,
            child: DarkCustomTextButton(
              text: 'أرسل كود التحقق للبريد الألكتروني',
              textStyle: CairoTextStyles.extraBold
                  .copyWith(fontSize: 20.sp, color: ColorsManager.white),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return OTPBottomSheet();
                  },
                );
              },
            ),
          ),
          verticalSpace(100),
          SizedBox(
            width: 80.w,
            height: 80.h,
            child: GestureDetector(
              onTap: () {
                context.pushNamed(Routing.firstPasswordSignupScreen);
              },
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
