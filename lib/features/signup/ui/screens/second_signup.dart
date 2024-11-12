import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/regex.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/Dark_Custom_text_field.dart';
import 'package:graduation_project/core/widgets/indecator.dart';
import 'package:graduation_project/features/signup/logic/signup_cubit.dart';
import 'package:graduation_project/features/signup/ui/widget/signup_screen.dart';

class SecondSignup extends StatefulWidget {
  const SecondSignup({super.key});

  @override
  State<SecondSignup> createState() => _SecondSignupState();
}

class _SecondSignupState extends State<SecondSignup> {
  bool isEmailEmpty = false;
  bool isPhoneEmpty = false;
  bool isPhoneInvalid = false; // Flag to check phone validation
  bool isEmailInvalid = false; // Flag to check email validation

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Function to validate and proceed with the data submission
  void validateAndProceed() {
    setState(() {
      isEmailEmpty = emailController.text.isEmpty;
      isPhoneEmpty = phoneController.text.isEmpty;

      isEmailInvalid = !isValidEmail(emailController.text);

      isPhoneInvalid = !isValidPhoneNumber(phoneController.text);
    });

    if (!isEmailEmpty && !isPhoneEmpty && !isEmailInvalid && !isPhoneInvalid) {
      final signupCubit = BlocProvider.of<SignupCubit>(context);

      signupCubit.updateContactDetails(
          emailController.text, phoneController.text);

      log(emailController.text);
      log(phoneController.text);

      context.pushNamed(Routing.firstPasswordSignupScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupContactDetailsUpdated) {
          context.pushNamed(Routing.firstPasswordSignupScreen);
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
                  showError: isEmailEmpty || isEmailInvalid,
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
                  showError: isPhoneEmpty || isPhoneInvalid,
                  keyboardType: TextInputType.number,
                  labelText: "ادخل رقم الهاتف",
                  borderCircular: 50.sp,
                  controller: phoneController,
                  textColor: ColorsManager.grey,
                ),
              ),
              verticalSpace(275.sp),
              SizedBox(
                width: 80.w,
                height: 80.h,
                child: GestureDetector(
                  onTap: validateAndProceed, // Call the validateAndProceed function
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
      },
    );
  }
}
