import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/dark_custom_text_field.dart';
import 'package:graduation_project/core/widgets/date_bottom_sheet.dart';
import 'package:graduation_project/core/widgets/indecator.dart';
import 'package:graduation_project/core/widgets/item_bottom_sheet.dart';
import 'package:graduation_project/core/widgets/sexual_items.dart';
import 'package:graduation_project/features/signup/logic/signup_cubit.dart';
import 'package:graduation_project/features/signup/ui/widget/signup_screen.dart';

class FirstSignup extends StatefulWidget {
  const FirstSignup({super.key});

  @override
  _FirstSignupState createState() => _FirstSignupState();
}

class _FirstSignupState extends State<FirstSignup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  bool isNameEmpty = false;
  bool isGenderEmpty = false;
  bool isDateEmpty = false;
  bool isCityEmpty = false;

  void validateAndProceed() {
    setState(() {
      isNameEmpty = nameController.text.isEmpty;
      isGenderEmpty = genderController.text.isEmpty;
      isDateEmpty = dateController.text.isEmpty;
      isCityEmpty = cityController.text.isEmpty;
    });

    if (!isNameEmpty && !isGenderEmpty && !isDateEmpty && !isCityEmpty) {
      final signupCubit = BlocProvider.of<SignupCubit>(context);
      signupCubit.updateUserDetails(
        nameController.text,
        dateController.text,
        genderController.text,
        cityController.text,
      );
      log(nameController.text);
      log(dateController.text);
      log(genderController.text);
      log(cityController.text);
      context.pushNamed(Routing.secondSignUpScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupUserDetailsUpdated) {
          context.pushNamed(Routing.secondSignUpScreen);
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
              ////////////// الاسم //////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "الأسم",
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
                  labelText: "إدخال الاسم الثلاثي",
                  borderCircular: 50.sp,
                  controller: nameController,
                  textColor: ColorsManager.white,
                  showError: isNameEmpty,
                ),
              ),
              verticalSpace(28.h),
              ////////////// الجنس //////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "الجنس",
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
                child: sexualType(
                  showError: isGenderEmpty,
                  svgIcons: const [
                    "assets/SVGs/icons/male.svg",
                    "assets/SVGs/icons/female.svg"
                  ],
                  height: 300.h,
                  textColor: ColorsManager.black,
                  labelText: "إدخل نوع الجنس",
                  items: const ["ذكر", "أنثى"],
                  controller: genderController,
                  borderCircular: 50.sp,
                ),
              ),
              verticalSpace(28.h),
              ////////////// تاريخ الميلاد //////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "تاريخ الميلاد",
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
                child: CustomDateField(
                  showError: isDateEmpty,
                  textColor: ColorsManager.white,
                  controller: dateController,
                ),
              ),
              verticalSpace(28.h),
              ////////////// المحافظة //////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "المحافظة",
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
                child: CustomSelectionTextField(
                  showSearch: true,
                  showError: isCityEmpty,
                  height: 700.h,
                  textColor: ColorsManager.black,
                  labelText: "إدخل المحافظة",
                  items: cities,
                  controller: cityController,
                  borderCircular: 50.sp,
                  svgIcons:citiesIcons,
                ),
              ),
              verticalSpace(28.h),
              ////////////// مؤشر الدائرة //////////////
              SizedBox(
                width: 80.w,
                height: 80.h,
                child: GestureDetector(
                  onTap: validateAndProceed,
                  child: CircleProgressBar(
                    animationDuration: const Duration(seconds: 1),
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: ColorsManager.secondGreen,
                    value: 0.25,
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
