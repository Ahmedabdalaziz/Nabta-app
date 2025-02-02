import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class DiagnosticQuestions extends StatefulWidget {
  @override
  _DiagnosticQuestionsState createState() => _DiagnosticQuestionsState();
}

class _DiagnosticQuestionsState extends State<DiagnosticQuestions> {

  Map<String, String?> answers = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "أسئلة تشخيصية",
            style: CairoTextStyles.bold.copyWith(
              fontSize: 24.sp,
              color: ColorsManager.secondGreen,
            ),
          ),
          verticalSpace(20.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: questions.map((question) {
              return diagnosticQuestionItem(question);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget diagnosticQuestionItem(String question) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            question,
            style: CairoTextStyles.bold.copyWith(
              fontSize: 18.sp,
              color: ColorsManager.secondGreen,
            ),
          ),
          verticalSpace(24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              optionButton(question, "غير متأكد"),
              horizontalSpace(65.w),
              optionButton(question, "لا"),
              horizontalSpace(65.w),
              optionButton(question, "نعم"),
            ],
          ),
        ],
      ),
    );
  }

  Widget optionButton(String question, String option) {
    return Row(
      children: [
        Text(option, style: CairoTextStyles.medium.copyWith(fontSize: 18.sp)),
        horizontalSpace(8.w),
        cCheckBox(
          isChecked: answers[question] == option,
          onTap: () {
            setState(() {
              answers[question] = answers[question] == option ? null : option;
            });
          },
          size: 28.w,
        ),
      ],
    );
  }
}

Widget cCheckBox({
  required bool isChecked,
  required VoidCallback onTap,
  required double size,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isChecked ? ColorsManager.mainGreen : Colors.transparent,
        borderRadius: BorderRadius.circular(size * 0.2),
        border: Border.all(color: ColorsManager.mainGreen, width: size * 0.05),
      ),
      child: isChecked
          ? Icon(Icons.check, color: ColorsManager.white, size: size * 0.6)
          : null,
    ),
  );
}
