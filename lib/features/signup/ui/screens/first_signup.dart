import 'package:flutter/material.dart';
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
import 'package:graduation_project/features/signup/ui/widget/signup_screen.dart';

///هنا اول صفحة تسجيل فيها الاسم والجنس والميلاد والمحافظة
/// وف الاخر انديكيتور بيتحرك فقعته من باكدج وعدلت عليه هتلاقيه في فايل الويديجت

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
      context.pushNamed(Routing.secondSignUpScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignupScreen(
      customContent: Column(
        children: [
          //////////////////////////////name/////////////////////////////
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
          ////////////////////////////////sex///////////////////////
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "الجنس",
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
              showError: isGenderEmpty,
              svgIconLeft: const [],
              svgIconRight: const [
                "assets/SVGs/icons/male.svg",
                "assets/SVGs/icons/female.svg"
              ],
              height: 300.h,
              textColor: ColorsManager.white,
              labelText: "إدخل نوع الجنس",
              items: const ["ذكر", "أنثى"],
              controller: genderController,
              borderCircular: 50.sp,
            ),
          ),
          verticalSpace(28.h),
          ////////////////////////////////date///////////////////////
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
          ////////////////////////////////city///////////////////////
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
              showSearch:true,
              showError: isCityEmpty,
              svgIconLeft: const [],
              svgIconRight: const [],
              height: 700.h,
              textColor: ColorsManager.white,
              labelText: "إدخل المحافظة",
              items: governorates,
              controller: cityController,
              borderCircular: 50.sp,
            ),
          ),
          verticalSpace(28.h),
          /////////////////////////////Circle Progress Bar//////////////////////////
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
  }
}
