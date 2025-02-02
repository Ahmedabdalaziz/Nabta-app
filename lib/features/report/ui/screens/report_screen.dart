import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/home/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:graduation_project/features/report/ui/widgets/on_choice_page.dart';

class ReportScreen extends StatefulWidget {
  final Widget customWidget;

  const ReportScreen({
    required this.customWidget,
    super.key,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _currentIndex = 0;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: ColorsManager.white,
      floatingActionButton: FloatingActionButton(

        onPressed: () {},
        elevation: 3,
        backgroundColor: ColorsManager.backGreen,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
        child: SvgPicture.asset('assets/SVGs/home/scan.svg'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/SVGs/home/مقاس موبايلي (1).png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  verticalSpace(75.h),
                  Row(
                    children: [
                      horizontalSpace(15.w),
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              ColorsManager.mainGreen.withOpacity(0.05),
                          radius: 26.r,
                          child: SvgPicture.asset(arrowBack),
                        ),
                      ),
                      horizontalSpace(110.w),
                      Text("إبلاغ بيطري",
                          style: CairoTextStyles.bold.copyWith(
                              fontSize: 28.sp, color: ColorsManager.mainGreen)),
                    ],
                  ),
                  verticalSpace(42.h),
                  OnChoicePage(
                    pageController: pageController,
                    isCaseDetails: true,
                    isContactAndLocation: false,
                  ),
                  verticalSpace(16.h),
                  widget.customWidget,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
