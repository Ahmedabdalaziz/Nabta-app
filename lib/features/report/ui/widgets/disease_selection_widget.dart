import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/app_checked_box.dart';

class DiseaseSelectionWidget extends StatelessWidget {
  final Map<String, bool> selectedMain;
  final Map<String, Map<String, bool>> selectedSub;
  final Function(String) onMainCategoryToggle;
  final Function(String, String) onSubCategoryToggle;

  const DiseaseSelectionWidget({
    super.key,
    required this.selectedMain,
    required this.selectedSub,
    required this.onMainCategoryToggle,
    required this.onSubCategoryToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.w,vertical: 32.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("تحديد الأصابة",
                  style: CairoTextStyles.bold
                      .copyWith(fontSize: 22.sp, color: ColorsManager.secondGreen)),
            ],
          ),
          verticalSpace(32.h),
          Column(
            children: diseaseCategories.keys.map((category) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => onMainCategoryToggle(category),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(category,
                            style: CairoTextStyles.bold.copyWith(
                                fontSize: 18.sp,
                                color: ColorsManager.secondGreen)),
                        horizontalSpace(8.w),
                        customCheckBox(
                          isChecked: selectedMain[category] ?? false,
                          onTap: () => onMainCategoryToggle(category),
                          size: 42.w,
                        ),
                      ],
                    ),
                  ),
                  if (selectedMain[category] == true)
                    ...diseaseCategories[category]!.map((subCategory) {
                      return Padding(
                        padding: EdgeInsets.only(right: 20.w, top: 16.h),
                        child: GestureDetector(
                          onTap: () =>
                              onSubCategoryToggle(category, subCategory),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(subCategory,
                                  style: CairoTextStyles.medium.copyWith(
                                      fontSize: 18.sp,
                                      color: ColorsManager.secondGreen)),
                              horizontalSpace(8.w),
                              customCheckBox(
                                isChecked:
                                    selectedSub[category]![subCategory] ??
                                        false,
                                onTap: () =>
                                    onSubCategoryToggle(category, subCategory),
                                size: 24.w,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  verticalSpace(12.h),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
