import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/app_checked_box.dart';

class NameOfUser extends StatefulWidget {
  final String mainString;
  final VoidCallback onTap;
  final bool isChecked;

  const NameOfUser(
      {super.key,
      required this.mainString,
      required this.onTap,
      required this.isChecked});

  @override
  State<NameOfUser> createState() => _NameOfUserState();
}

class _NameOfUserState extends State<NameOfUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          textDirection: TextDirection.rtl,
          children: [
            customCheckBox(
                isChecked: widget.isChecked, onTap: widget.onTap, size: 32.sp),
            horizontalSpace(10.w),
            Text(widget.mainString,
                style: CairoTextStyles.bold.copyWith(
                    fontSize: 16.sp, color: ColorsManager.secondGreen)),
          ],
        ),

      ],
    );
  }
}

