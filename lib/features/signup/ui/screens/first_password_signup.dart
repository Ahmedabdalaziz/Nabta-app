import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/regex.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:graduation_project/core/widgets/indecator.dart';
import 'package:graduation_project/features/signup/logic/signup_cubit.dart';
import 'package:graduation_project/features/signup/ui/widget/signup_screen.dart';

import '../../../../../core/helper/spacing.dart';
import '../../../../../core/helper/strings.dart';
import '../../../../../core/theming/style_manager.dart';
import '../../../../../core/widgets/Dark_Custom_text_field.dart';

class FirstPasswordSignup extends StatefulWidget {
  const FirstPasswordSignup({super.key});

  @override
  State<FirstPasswordSignup> createState() => _FirstPasswordSignupState();
}

class _FirstPasswordSignupState extends State<FirstPasswordSignup> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool isChanged = false;
  bool isLengthValid = false;
  bool hasUpperAndLower = false;
  bool hasNumber = false;
  bool identical = false;

  bool _isLength(String password) => isLengthValid = password.length >= 8;

  bool _isUpperAndLower(String password) =>
      hasUpperAndLower = password.contains(RegExp(r'(?=.*[a-z])(?=.*[A-Z])'));

  bool _isNumber(String password) =>
      hasNumber = password.contains(RegExp(r'[0-9]'));

  Color _coloring(bool condition) =>
      condition ? ColorsManager.mainGreen : ColorsManager.red;

  void checkPassword(String password) {
    setState(() {
      isLengthValid = password.length >= 8;
      hasUpperAndLower = password.contains(RegExp(r'(?=.*[a-z])(?=.*[A-Z])'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      identical = password == confirmController.text;
    });
  }

  bool _isPasswordValid() {
    return isLengthValid && hasUpperAndLower && hasNumber && identical;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          context.pushNamed(Routing.uploadingImageScreen);
        } else if (state is SignupError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.message}")),
          );
        }
      },
      builder: (context, state) {
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
                  onChanged: (value) {
                    setState(() {
                      isChanged = true;
                    });
                    // Update the cubit with the password
                    context.read<SignupCubit>().updatePassword(value);
                  },
                  textAlign: TextAlign.right,
                  labelText: "أدخل كلمة المرور",
                  borderCircular: 50.sp,
                  controller: passwordController,
                  textColor: ColorsManager.white,
                  isPassword: true,
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
                  isPassword: true,
                  textAlign: TextAlign.right,
                  labelText: "تأكيد كلمة المرور",
                  borderCircular: 50.sp,
                  controller: confirmController,
                  textColor: ColorsManager.white,
                  onChanged: (value) {
                    checkPassword(passwordController.text);
                  },
                ),
              ),
              verticalSpace(20.sp),
              SizedBox(
                child: isChanged
                    ? Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 408.w,
                                height: 22.5.h,
                                child: Text(
                                  "كلمة المرور لا تقل عن 8 أحرف ",
                                  textAlign: TextAlign.right,
                                  style: CairoTextStyles.bold.copyWith(
                                    fontSize: 12.sp,
                                    color: _coloring(
                                        _isLength(passwordController.text)),
                                  ),
                                ),
                              ),
                              horizontalSpace(8.sp),
                              Container(
                                width: 10.sp,
                                height: 10.sp,
                                decoration: BoxDecoration(
                                  color: _coloring(
                                      _isLength(passwordController.text)),
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
                                child: Text(
                                  "كلمة المرور تحتوي على حروف كبيرة وصغيرة ",
                                  textAlign: TextAlign.right,
                                  style: CairoTextStyles.bold.copyWith(
                                    fontSize: 12.sp,
                                    color: _coloring(_isUpperAndLower(
                                        passwordController.text)),
                                  ),
                                ),
                              ),
                              horizontalSpace(8.sp),
                              Container(
                                width: 10.sp, // حجم النقطة
                                height: 10.sp,
                                decoration: BoxDecoration(
                                  color: _coloring(_isUpperAndLower(
                                      passwordController.text)), // لون النقطة
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
                                child: Text(
                                  "كلمة المرور تحتوي على أرقام",
                                  textAlign: TextAlign.right,
                                  style: CairoTextStyles.bold.copyWith(
                                    fontSize: 12.sp,
                                    color: _coloring(
                                        _isNumber(passwordController.text)),
                                  ),
                                ),
                              ),
                              horizontalSpace(8.sp),
                              Container(
                                width: 10.sp, // حجم النقطة
                                height: 10.sp,
                                decoration: BoxDecoration(
                                  color: _coloring(
                                      _isLength(passwordController.text)),
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
                                child: Text(
                                  "كلمتا المرور متطابقتان ",
                                  textAlign: TextAlign.right,
                                  style: CairoTextStyles.bold.copyWith(
                                    fontSize: 12.sp,
                                    color: isMatch(passwordController.text,
                                            confirmController.text)
                                        ? ColorsManager.mainGreen
                                        : ColorsManager.red,
                                  ),
                                ),
                              ),
                              horizontalSpace(8.sp),
                              Container(
                                width: 10.sp,
                                height: 10.sp,
                                decoration: BoxDecoration(
                                  color: isMatch(passwordController.text,
                                          confirmController.text)
                                      ? ColorsManager.mainGreen
                                      : ColorsManager.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 90.h,
                        width: 400.w,
                        child: SvgPicture.asset(WarningBoxSvg),
                      ),
              ),
              verticalSpace(30.sp),
              SizedBox(
                height: 56.h,
                width: 408.w,
                child: DarkCustomTextButton(
                  text: 'حفظ كلمة المرور',
                  textStyle: CairoTextStyles.extraBold.copyWith(
                    fontSize: 20.sp,
                    color: _isPasswordValid()
                        ? ColorsManager.mainGreen
                        : const Color(0xFF8AA5A4),
                  ),
                  onPressed: () {
                    if (_isPasswordValid()) {
                      context
                          .read<SignupCubit>()
                          .updatePassword(passwordController.text);
                      log(passwordController.text);
                      context.pushNamed(Routing.uploadingImageScreen);
                    }
                  },
                ),
              ),
              verticalSpace(40.sp),
              SizedBox(
                width: 80.w,
                height: 80.h,
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<SignupCubit>()
                        .updatePassword(passwordController.text);
                    context.pushNamed(Routing.uploadingImageScreen);
                  },
                  child: CircleProgressBar(
                    animationDuration: const Duration(seconds: 1),
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: ColorsManager.secondGreen,
                    value: 1,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
