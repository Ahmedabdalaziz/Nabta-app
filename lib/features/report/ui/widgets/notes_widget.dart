import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/dark_Custom_text_field.dart';

class NotesWidget extends StatelessWidget {
  final String notes;
  final Function(String) onNotesChanged;

  const NotesWidget({
    Key? key,
    required this.notes,
    required this.onNotesChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "الملاحظات",
            style: CairoTextStyles.bold.copyWith(
              fontSize: 22.sp,
              color: ColorsManager.secondGreen,
            ),
          ),
          verticalSpace(8.h),
          DarkCustomTextField(
            maxLines: 5,
            onChanged: onNotesChanged,
            textColor: ColorsManager.mainGreen,
            hintTextColor: ColorsManager.secondGreen,
            hintTextFontSize: 20.sp,
            labelText: "اكتب وصفًا مختصرًا للحالة وأي ملاحظات هنا",
            fillColor: ColorsManager.greenWhite,
            borderWides: 1,
            borderColor: ColorsManager.mainGreen,
            borderCircular:32.r,
          ),
        ],
      ),
    );
  }
}
