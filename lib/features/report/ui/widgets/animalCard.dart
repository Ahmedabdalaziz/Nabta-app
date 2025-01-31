import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/core/theming/color.dart';

class AnimalCard extends StatefulWidget {
  final String animalIcon;

  const AnimalCard({super.key, required this.animalIcon});

  @override
  State<StatefulWidget> createState() => _AnimalCard();
}

class _AnimalCard extends State<AnimalCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.w,
      height: 85.h,
      decoration: BoxDecoration(
        color: ColorsManager.lightWhite,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: ColorsManager.mainGreen,
          width: 1.w,
        ),
      ),
      child: Center(
        child: Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            color: ColorsManager.lightWhite,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: SvgPicture.asset(widget.animalIcon),
        ),
      ),
    );
  }
}
