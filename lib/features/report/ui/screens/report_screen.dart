import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/home/ui/home_background.dart';
import 'package:graduation_project/features/report/ui/widgets/on_choice_page.dart';

class ReportScreen extends StatefulWidget {
  final Widget customWidget;
  final bool details;
  final bool location;

  const ReportScreen({
    required this.customWidget,
    super.key,
    this.details = false,
    this.location = false,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return HomeBackground(
        child: Column(
      children: [
        verticalSpace(55.h),
        Row(
          children: [
            horizontalSpace(15.w),
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: CircleAvatar(
                backgroundColor: ColorsManager.mainGreen.withOpacity(0.05),
                radius: 26.r,
                child: SvgPicture.asset(arrowBack),
              ),
            ),
            horizontalSpace(110.w),
            Text("إبلاغ بيطري",
                style: CairoTextStyles.bold
                    .copyWith(fontSize: 28.sp, color: ColorsManager.mainGreen)),
          ],
        ),
        verticalSpace(42.h),
        OnChoicePage(
          pageController: pageController,
          isCaseDetails: widget.details,
          isContactAndLocation: widget.location,
        ),
        verticalSpace(16.h),
        widget.customWidget,
      ],
    ));
  }
}
