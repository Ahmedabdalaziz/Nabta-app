import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/color.dart';

class NonAvailableStock extends StatelessWidget {
  const NonAvailableStock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 120.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: ColorsManager.greenWhite,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/SVGs/plants/soonPotato.png',
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }
}
