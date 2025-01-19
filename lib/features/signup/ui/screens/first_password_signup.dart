import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/Dark_Custom_text_field.dart';
import 'package:graduation_project/core/widgets/indecator.dart';
import 'package:graduation_project/features/signup/logic/signup_cubit.dart';
import 'package:graduation_project/features/signup/ui/widget/signup_screen.dart';

class FirstPasswordSignup extends StatefulWidget {
  const FirstPasswordSignup({super.key});

  @override
  State<FirstPasswordSignup> createState() => _FirstPasswordSignupState();
}

class _FirstPasswordSignupState extends State<FirstPasswordSignup> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool isPasswordEmpty = false;
  bool isConfirmEmpty = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupPasswordUpdated) {
          context.pushNamed(Routing.uploadingImageScreen);
        } else if (state is SignupError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.message}")),
          );
        }
      },
      builder: (context, state) {
        final signupCubit = BlocProvider.of<SignupCubit>(context);

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
                  showError: isPasswordEmpty, // Pass the error state
                  onChanged: (value) {
                    setState(() {
                      isPasswordEmpty = value.isEmpty;
                    });
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
                  showError: isConfirmEmpty, // Pass the error state
                  isPassword: true,
                  textAlign: TextAlign.right,
                  labelText: "تأكيد كلمة المرور",
                  borderCircular: 50.sp,
                  controller: confirmController,
                  textColor: ColorsManager.white,
                  onChanged: (value) {
                    setState(() {
                      isConfirmEmpty = value.isEmpty;
                    });
                  },
                ),
              ),
              verticalSpace(20.sp),
              SizedBox(
                width: 80.w,
                height: 80.h,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordEmpty = passwordController.text.isEmpty;
                      isConfirmEmpty = confirmController.text.isEmpty;
                    });

                    if (!isPasswordEmpty && !isConfirmEmpty) {
                      if (signupCubit.isPasswordValid(passwordController.text) &&
                          signupCubit.isConfirmPasswordValid(
                              passwordController.text, confirmController.text)) {
                        signupCubit.updatePassword(passwordController.text);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please enter a valid password")),
                        );
                      }
                    }
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