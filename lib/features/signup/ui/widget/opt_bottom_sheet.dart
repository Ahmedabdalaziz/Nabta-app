import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class OTPBottomSheet extends StatefulWidget {
  const OTPBottomSheet({super.key});

  @override
  State<OTPBottomSheet> createState() => _OTPBottomSheetState();
}

class _OTPBottomSheetState extends State<OTPBottomSheet> {
  bool isChanged = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          verticalSpace(20.h),
          Text(
            "التحقق من البريد الألكتروني",
            style: CairoTextStyles.bold.copyWith(
              fontSize: 26.sp,
              color: ColorsManager.secondGreen,
            ),
          ),
          verticalSpace(16.h),
          Text(
            "لقد أرسلنا إلى بريدك الإلكتروني رمز تحقق مكون من 6 أرقام. ",
            textAlign: TextAlign.center,
            style: CairoTextStyles.bold.copyWith(
              fontSize: 12.sp,
              color: ColorsManager.secondGreen,
            ),
          ),
          verticalSpace(4.h),
          Text(
            "يرجى إدخال هذا الرمز لتأكيد صحة بريدك الإلكتروني،",
            textAlign: TextAlign.center,
            style: CairoTextStyles.bold.copyWith(
              fontSize: 12.sp,
              color: ColorsManager.secondGreen,
            ),
          ),
          verticalSpace(4.h),
          Text(
            "ومن ثم سيتم ربط حسابك به وتفعيله.",
            textAlign: TextAlign.center,
            style: CairoTextStyles.bold.copyWith(
              fontSize: 12.sp,
              color: ColorsManager.secondGreen,
            ),
          ),
          verticalSpace(40.h),
          SvgPicture.asset(
            "assets/SVGs/sign_in/OTP.svg",
          ),
          verticalSpace(43.h),
          OtpTextField(
            autoFocus: false,
            focusedBorderColor: ColorsManager.secondGreen,
            filled: true,
            textStyle: CairoTextStyles.bold.copyWith(
              fontSize: 24.sp,
              color: ColorsManager.secondGreen,
            ),
            borderRadius: BorderRadius.circular(16.sp),
            borderColor: ColorsManager.secondGreen,
            numberOfFields: 6,
            showFieldAsBox: true,
            onCodeChanged: (String code) {
              setState(() {
                isChanged = code.isNotEmpty;
              });
            },
            onSubmit: (String verificationCode) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: ColorsManager.secondGreen,
                    content: Container(
                      height: 200.h,
                      width: 400.h,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "عذرًا ، البريد الإلكتروني أو كلمة المرور غير صحيحين . يُرجى التحقق من البيانات والمحاولة مرة أخرى .",
                        style: CairoTextStyles.bold.copyWith(
                          fontSize: 20.sp,
                          color: ColorsManager.white,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          verticalSpace(43.h),
          SizedBox(
            height: 56.h,
            width: 400.w,
            child: DarkCustomTextButton(
              bottomColor: isChanged
                  ? ColorsManager.secondGreen
                  : const Color(0xFF8AA5A4),
              text: "التحقق من الرمز",
              onPressed: isChanged
                  ? () {
                      context.pushNamed(Routing.firstPasswordSignupScreen);
                    }
                  : null,
              textStyle: CairoTextStyles.extraBold.copyWith(
                fontSize: 20.sp,
                color: ColorsManager.white,
              ),
            ),
          ),
          verticalSpace(24.h),
          SizedBox(
            height: 56.h,
            width: double.infinity,
            child: DarkCustomTextButton(
              textColor: ColorsManager.secondGreen,
              bottomColor: ColorsManager.white,
              text: "اعادة ارسال الرمز",
              onPressed: () {
                context.pop();
              },
              textStyle: CairoTextStyles.extraBold.copyWith(
                fontSize: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
