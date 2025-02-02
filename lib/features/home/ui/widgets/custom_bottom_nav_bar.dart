import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:graduation_project/core/theming/color.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      HugeIcons.strokeRoundedHome05,
      HugeIcons.strokeRoundedPlant01,
      HugeIcons.strokeRoundedMessage01,
      HugeIcons.strokeRoundedMenu01,
    ];

    return AnimatedBottomNavigationBar(
      elevation: 0,
      splashSpeedInMilliseconds: 1,
      blurEffect: false,
      icons: icons,
      activeIndex: currentIndex,
      onTap: onTap,
      gapLocation: GapLocation.center,
      leftCornerRadius: 25.r,
      rightCornerRadius: 25.r,
      backgroundColor: ColorsManager.lightWhite.withOpacity(0.7),
      activeColor: ColorsManager.mainGreen,
      inactiveColor: ColorsManager.secondGreen,
      height: 62.h,
      borderWidth: 424.w,
      notchSmoothness: NotchSmoothness.smoothEdge,
      iconSize: 35.sp,
    );
  }
}