import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class PlantModel {
  final String arabicName;
  final String englishName;
  final String imagePath;

  PlantModel({
    required this.arabicName,
    required this.englishName,
    required this.imagePath,
  });
}

class PlantSelectionWidget extends StatelessWidget {
  final Function(String) onSelect;

  PlantSelectionWidget({
    super.key,
    required this.onSelect,
  });

  final List<PlantModel> plants = [
    PlantModel(
      arabicName: "ذرة",
      englishName: "corn",
      imagePath: "assets/SVGs/plants/cane.png",
    ),
    PlantModel(
      arabicName: "طماطم",
      englishName: "tomato",
      imagePath: "assets/SVGs/plants/cotton.png",
    ),
    PlantModel(
      arabicName: "قصب",
      englishName: "sugarcane",
      imagePath: "assets/SVGs/plants/cotton.png",
    ),
    PlantModel(
      arabicName: "بطاطس",
      englishName: "potato",
      imagePath: "assets/SVGs/plants/potato.png",
    ),
    PlantModel(
      arabicName: " ",
      englishName: "corn",
      imagePath: "assets/SVGs/plants/soonBeans.png",
    ),
    PlantModel(
      arabicName: " ",
      englishName: "corn",
      imagePath: "assets/SVGs/plants/soonBeans.png",
    ),
  ];

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
                children: plants
                    .map((plant) => _buildPlantOption(
                          plant.arabicName,
                          plant.englishName,
                          plant.imagePath,
                          onSelect,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlantOption(
    String arabicLabel,
    String englishLabel,
    String image,
    Function(String) onSelect,
  ) {
    return GestureDetector(
      onTap: () => onSelect(englishLabel),
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
                arabicLabel,
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
