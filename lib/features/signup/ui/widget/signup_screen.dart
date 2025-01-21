import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/features/login/ui/background.dart';

import '../../../../core/theming/style_manager.dart';

class SignupScreen extends StatefulWidget {
  final Widget customContent;
  final String title;

  const SignupScreen({
    super.key,
    required this.customContent,
    this.title = "انشاء حساب",
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  void dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: dismissKeyboard,
        child: Background(
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
              verticalSpace(20.h),
              Center(
                child: Text(
                  widget.title,
                  style: CairoTextStyles.extraBold.copyWith(
                      fontSize: 30.sp, color: ColorsManager.secondGreen),
                ),
              ),
              verticalSpace(38.h),
              widget.customContent,
            ],
          ),
        ),
      ),
    );
  }
}
