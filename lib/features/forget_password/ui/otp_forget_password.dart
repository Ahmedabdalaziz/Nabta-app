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
import 'package:graduation_project/features/forget_password/logic/send_forget_password_cubit.dart';

class OTPForgetPassword extends StatefulWidget {
  const OTPForgetPassword({super.key});

  @override
  State<OTPForgetPassword> createState() => _OTPForgetPasswordState();
}

class _OTPForgetPasswordState extends State<OTPForgetPassword> {
  String? otpCode;
  String? email;

  @override
  void initState() {
    super.initState();
    // استقبال الإيميل من صفحة نسيان كلمة المرور
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is String) {
        setState(() {
          email = args;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendForgetPasswordCubit, SendForgetPasswordState>(
      listener: (context, state) {
        if (state is SendOtpVerificationSuccess) {
          Navigator.pop(context); // إغلاق الـ loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          context.pushNamed(Routing.newPasswordScreen); // الانتقال لصفحة إعادة تعيين كلمة المرور
        } else if (state is SendOtpVerificationFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
          );
        } else if (state is ValidationError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is SendForgetPasswordSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is SendForgetPasswordFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
          );
        } else if (state is SendForgetPasswordLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(
              child: CircularProgressIndicator(
                color: ColorsManager.mainGreen,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        verticalSpace(40.sp),
                        Text(
                          "التحقق من البريد الإلكتروني",
                          style: CairoTextStyles.extraBold.copyWith(
                            fontSize: 30.sp,
                            color: ColorsManager.secondGreen,
                          ),
                        ),
                        verticalSpace(32.sp),
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
                        GestureDetector(
                          onTap: () {
                            context.pop(); // رجوع لصفحة نسيان كلمة المرور
                          },
                          child: Text(
                            "تعديل البريد الإلكتروني",
                            style: CairoTextStyles.extraBold.copyWith(
                              fontSize: 16.sp,
                              color: ColorsManager.mainGreen,
                            ),
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
                            otpCode = otp;
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
                              if (otpCode == null || otpCode!.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("من فضلك أدخل كود التفعيل"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else if (email == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("خطأ: لم يتم العثور على البريد الإلكتروني"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                context.read<SendForgetPasswordCubit>().verifyOtpCode(email!, otpCode!);
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
                              onPressed: () {
                                if (email != null) {
                                  context.read<SendForgetPasswordCubit>().sendForgetPasswordEmail(email!);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("لا يوجد بريد إلكتروني لإعادة إرسال الكود"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}