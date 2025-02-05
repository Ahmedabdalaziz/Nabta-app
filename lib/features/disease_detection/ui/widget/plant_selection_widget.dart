import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class PlantSelectionWidget extends StatelessWidget {
  final Function(String) onSelect;

  const PlantSelectionWidget({
    Key? key,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: 20,
      right: 20,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(15.spMax),
          decoration: BoxDecoration(
            color: ColorsManager.mainGreen.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ColorsManager.white, width: 1),
          ),
          child: Column(
            children: [
              verticalSpace(20.h),
              Text(
                "اختر النبات الذي تريد فحصه",
                style: CairoTextStyles.black.copyWith(
                  color: ColorsManager.white,
                  fontSize: 22.sp,
                ),
              ),
              verticalSpace(20.h),
              Wrap(
                spacing: 40.w,
                runSpacing: 15.h,
                children: [
                  _buildPlantOption(
                      "ذرة", "assets/SVGs/plants/cane.png", onSelect),
                  _buildPlantOption(
                      "قمح", "assets/SVGs/plants/corn2.png", onSelect),
                  _buildPlantOption(
                      "قمح", "assets/SVGs/plants/cotton.png", onSelect),
                  _buildPlantOption(
                      "أرز", "assets/SVGs/plants/cane.png", onSelect),
                  _buildPlantOption(
                      "أرز", "assets/SVGs/plants/cotton.png", onSelect),
                  _buildPlantOption(
                      "بصل", "assets/SVGs/plants/onion.png", onSelect),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlantOption(
      String label, String image, Function(String) onSelect) {
    return GestureDetector(
      onTap: () => onSelect(label),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: ColorsManager.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.mainGreen.withOpacity(0.5),
              blurRadius: 10.r,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                image,
                height: 100.h,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                label,
                style: CairoTextStyles.bold.copyWith(
                  color: ColorsManager.secondGreen,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
