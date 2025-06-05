import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/widgets/dark_Custom_text_field.dart';
import 'package:graduation_project/features/report/ui/widgets/name_of_user.dart';

class NameWithPhone extends StatefulWidget {
  final String name;
  final String labelString;
  final String option;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;


  const NameWithPhone({
    super.key,
    required this.name,
    required this.option,
    required this.keyboardType,
    required this.labelString,
    this.controller,
    this.onChanged,
  });

  @override
  State<NameWithPhone> createState() => _NameWithPhoneState();
}

class _NameWithPhoneState extends State<NameWithPhone> {
  bool isChecked = false;
  bool showAdditionalField = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NameOfUser(
          mainString: widget.name,
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
          },
          isChecked: isChecked,
        ),
        verticalSpace(16.h),
        NameOfUser(
          mainString: widget.option,
          onTap: () {
            setState(() {
              showAdditionalField = !showAdditionalField;
              isChecked = false;
            });
          },
          isChecked: showAdditionalField,
        ),
        if (showAdditionalField)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: DarkCustomTextField(
              onChanged: widget.onChanged,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.right,
              hintTextFontSize: 24.sp,
              hintTextColor: ColorsManager.secondGreen,
              labelText: widget.labelString,
              borderWides: 0.5.w,
              borderCircular: 25.r,
              textColor: ColorsManager.secondGreen,
              borderColor: ColorsManager.mainGreen,
              fillColor: ColorsManager.lightWhite,
            ),
          ),
      ],
    );
  }
}