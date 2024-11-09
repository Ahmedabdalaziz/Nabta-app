import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/bottom_sheet.dart';

class OTPBottomSheet extends StatefulWidget {
  const OTPBottomSheet({super.key});

  @override
  State<OTPBottomSheet> createState() => _OTPBottomSheetState();
}

class _OTPBottomSheetState extends State<OTPBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return CustomModalBottomSheet(
      height: 700.h,
      child: Column(
        children: [
          Text(
            "التحقق من البريد الألكتروني",
            style: CairoTextStyles.bold
                .copyWith(fontSize: 26.sp, color: ColorsManager.secondGreen),
          ),
          verticalSpace(16.h),
          Text(
            textAlign: TextAlign.center,
            "لقد أرسلنا إلى بريدك الإلكتروني رمز تحقق مكون من 6 أرقام. ",
            style: CairoTextStyles.bold
                .copyWith(fontSize: 12.sp, color: ColorsManager.secondGreen),
          ),
          verticalSpace(4.h),
          Text(
            textAlign: TextAlign.center,
            "يرجى إدخال هذا الرمز لتأكيد صحة بريدك الإلكتروني،",
            style: CairoTextStyles.bold
                .copyWith(fontSize: 12.sp, color: ColorsManager.secondGreen),
          ),
          verticalSpace(4.h),
          Text(
            textAlign: TextAlign.center,
            " ومن ثم سيتم ربط حسابك به وتفعيله.",
            style: CairoTextStyles.bold
                .copyWith(fontSize: 12.sp, color: ColorsManager.secondGreen),
          ),
          verticalSpace(40.h),
          SvgPicture.asset(
            "assets/SVGs/sign_in/OTP.svg",
          ),
          verticalSpace(43.h),
          OtpTextField(
            autoFocus: true,
            focusedBorderColor: ColorsManager.secondGreen,
            filled: true,
            textStyle: CairoTextStyles.bold
                .copyWith(fontSize: 24.sp, color: ColorsManager.secondGreen),
            borderRadius: BorderRadius.circular(16.sp),
            borderColor: ColorsManager.secondGreen,
            disabledBorderColor: ColorsManager.secondGreen,
            enabledBorderColor: ColorsManager.secondGreen,
            keyboardType: TextInputType.number,
            cursorColor: ColorsManager.secondGreen,
            fillColor: ColorsManager.white,
            numberOfFields: 6,
            showFieldAsBox: true,
            onCodeChanged: (String code) {},
            onSubmit: (String verificationCode) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Verification Code"),
                      content: Text('Code entered is $verificationCode'),
                    );
                  });
            }, // end onSubmit
          ),
        ],
      ),
    );
    ;
  }
}
