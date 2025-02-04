import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:graduation_project/core/widgets/otp_input.dart';
import 'package:graduation_project/features/forget_password/logic/active_email_cubit/email_active_cubit.dart';
import 'package:graduation_project/features/signup/ui/widget/signup_screen.dart';

class OTPScreen extends StatefulWidget {
  final String email;

  const OTPScreen({super.key, required this.email});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late String otpCode = '';

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  void _hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailActiveCubit, EmailActiveState>(
      listener: (context, state) {
        if (state is EmailActiveLoading) {
          _showLoadingDialog(context);
        } else {
          _hideLoadingDialog(context);
        }

        if (state is EmailActiveSuccess) {
          context.pushNamed(Routing.homeScreen);
        } else if (state is EmailActiveFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: ColorsManager.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return SignupScreen(
          title: "التحقق من البريد الإلكتروني",
          customContent: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "لقد أرسلنا إلى بريدك الإلكتروني",
                      style: CairoTextStyles.bold.copyWith(
                        fontSize: 12.sp,
                        color: ColorsManager.secondGreen,
                      ),
                    ),
                    verticalSpace(4.sp),
                    Text(
                      "رمز تحقق مكون من 6 أرقام. يرجى إدخال هذا الرمز لتأكيد صحة",
                      style: CairoTextStyles.bold.copyWith(
                        fontSize: 12.sp,
                        color: ColorsManager.secondGreen,
                      ),
                    ),
                    verticalSpace(4.sp),
                    Text(
                      "بريدك الإلكتروني، ومن ثم سيتم ربط حسابك به وتفعيله.",
                      style: CairoTextStyles.bold.copyWith(
                        fontSize: 12.sp,
                        color: ColorsManager.secondGreen,
                      ),
                    ),
                    verticalSpace(30.sp),
                    Text(
                      "تعديل البريد الإلكتروني",
                      style: CairoTextStyles.extraBold.copyWith(
                        fontSize: 16.sp,
                        color: ColorsManager.mainGreen,
                      ),
                    ),
                    verticalSpace(20.sp),
                    SvgPicture.asset(OTP),
                    verticalSpace(40.sp),
                    OTPInput(
                      boxHeight: 60.h,
                      boxWidth: 40.w,
                      spacing: 8.w,
                      length: 6,
                      onCompleted: (otp) {
                        setState(() {
                          otpCode = otp;
                        });
                      },
                    ),
                    verticalSpace(32.sp),
                    SizedBox(
                      width: 400.w,
                      child: DarkCustomTextButton(
                        text: 'التحقق من الرمز',
                        textStyle: CairoTextStyles.extraBold.copyWith(
                          fontSize: 20.sp,
                          color: ColorsManager.white,
                        ),
                        onPressed: () {
                          if (otpCode.isNotEmpty && widget.email.isNotEmpty) {
                            context
                                .read<EmailActiveCubit>()
                                .forgetActiveCode(widget.email, otpCode);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "من فضلك أدخل كود التفعيل وتأكد من وجود البريد الإلكتروني"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    verticalSpace(20.sp),
                    SizedBox(
                      width: 400.w,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorsManager.secondGreen,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(50.0.sp),
                        ),
                        child: DarkCustomTextButton(
                          textColor: ColorsManager.secondGreen,
                          bottomColor: ColorsManager.moreWhite,
                          text: 'إعادة إرسال الرمز',
                          textStyle: CairoTextStyles.extraBold.copyWith(
                            fontSize: 20.sp,
                            color: ColorsManager.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
