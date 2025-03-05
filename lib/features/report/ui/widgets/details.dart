import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class DiagnosticQuestions extends StatelessWidget {
  final Map<String, String?> answers;
  final Function(String, String?) onAnswerSelected;

  const DiagnosticQuestions({
    super.key,
    required this.answers,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "أسئلة تشخيصية",
            style: CairoTextStyles.bold
                .copyWith(fontSize: 22.sp, color: ColorsManager.secondGreen),
          ),
          verticalSpace(28.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: questions.map((question) {
                return diagnosticQuestionItem(question);
              }).toList(),
            ),
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
            style: CairoTextStyles.bold
                .copyWith(fontSize: 18.sp, color: ColorsManager.secondGreen),
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
          onTap: () => onAnswerSelected(
              question, answers[question] == option ? null : option),
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
