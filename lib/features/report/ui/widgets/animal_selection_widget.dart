import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/report/ui/widgets/animalCard.dart';

class AnimalSelectionWidget extends StatelessWidget {
  final String? selectedAnimal;
  final Function(String?) onAnimalSelected;

  const AnimalSelectionWidget({
    super.key,
    required this.selectedAnimal,
    required this.onAnimalSelected,
  });

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, String>> animalList = animals.entries.toList();
    List<MapEntry<String, String>> firstRow = animalList.sublist(0, 4);
    List<MapEntry<String, String>> secondRow = animalList.sublist(4, 8);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("نوع الحيوان",
                  style: CairoTextStyles.bold.copyWith(
                      fontSize: 22.sp, color: ColorsManager.secondGreen)),
            ],
          ),
        ),
        verticalSpace(26.h),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: firstRow.map((entry) {
                return GestureDetector(
                  onTap: () => onAnimalSelected(entry.key),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: AnimalCard(
                      animalIcon: entry.value,
                      animalName: entry.key,
                      isSelected: selectedAnimal == entry.key,
                      isDisabled:
                          selectedAnimal != null && selectedAnimal != entry.key,
                    ),
                  ),
                );
              }).toList(),
            ),
            verticalSpace(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: secondRow.map((entry) {
                return GestureDetector(
                  onTap: () => onAnimalSelected(entry.key),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: AnimalCard(
                      animalIcon: entry.value,
                      animalName: entry.key,
                      isSelected: selectedAnimal == entry.key,
                      isDisabled:
                          selectedAnimal != null && selectedAnimal != entry.key,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
