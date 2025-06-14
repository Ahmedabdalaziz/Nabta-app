import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:graduation_project/core/widgets/dark_custom_text_field.dart';
import 'package:graduation_project/features/forget_password/logic/send_forget_password_cubit.dart';
import 'package:graduation_project/features/login/ui/background.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isEmpty = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendForgetPasswordCubit, SendForgetPasswordState>(
      listener: (context, state) {
        if (state is SendForgetPasswordSuccess) {
          Navigator.pop(context);
          context.pushNamed(Routing.otpForgetPassword, arguments: emailController.text);
        } else if (state is ValidationError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is SendForgetPasswordFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
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
                  style: CairoTextStyles.extraBold.copyWith(
                    fontSize: 30.sp,
                    color: ColorsManager.secondGreen,
                  ),
                ),
              ),
              verticalSpace(32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                child: Center(
                  child: Text(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    "الرجاء إدخال البريد الإلكتروني الذي تم تسجيله مسبقًا في حسابك، حتى نتمكن من إرسال الكود التأكيدي لاستعادة الوصول أو التحقق من حسابك.",
                    style: CairoTextStyles.bold.copyWith(
                      fontSize: 16.sp,
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
                    "البريد الإلكتروني",
                    textAlign: TextAlign.right,
                    style: CairoTextStyles.extraBold.copyWith(
                      fontSize: 20.sp,
                      color: ColorsManager.secondGreen,
                    ),
                  ),
                  horizontalSpace(32.sp),
                ],
              ),
              verticalSpace(12.sp),
              SizedBox(
                width: 400.w,
                height: 56.h,
                child: DarkCustomTextField(
                  onChanged: (value) {
                    setState(() {
                      isEmpty = value.isEmpty;
                    });
                  },
                  showError: isEmpty,
                  textAlign: TextAlign.right,
                  labelText: "أدخل بريدك الإلكتروني",
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
                  textStyle: CairoTextStyles.extraBold.copyWith(
                    fontSize: 20.sp,
                    color: ColorsManager.white,
                  ),
                  onPressed: () {
                    if (emailController.text.isEmpty) {
                      setState(() {
                        isEmpty = true;
                      });
                    } else {
                      context
                          .read<SendForgetPasswordCubit>()
                          .sendForgetPasswordEmail(emailController.text);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}