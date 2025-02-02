import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/app_checked_box.dart';
import 'package:graduation_project/features/report/ui/screens/report_screen.dart';
import 'package:graduation_project/features/report/ui/widgets/animalCard.dart';
import 'package:graduation_project/features/report/ui/widgets/details.dart';
import 'package:graduation_project/features/report/ui/widgets/upload_image.dart';

class FirstReportScreen extends StatefulWidget {
  const FirstReportScreen({super.key});

  @override
  State<FirstReportScreen> createState() => _FirstReportScreenState();
}

class _FirstReportScreenState extends State<FirstReportScreen> {
  bool isPet = false;
  bool isSelected = false;
  Map<String, bool> selectedMain = {};
  Map<String, Map<String, bool>> selectedSub = {};

  @override
  void initState() {
    super.initState();
    for (var category in diseaseCategories.keys) {
      selectedMain[category] = false;
      selectedSub[category] = {};
      for (var sub in diseaseCategories[category]!) {
        selectedSub[category]![sub] = false;
      }
    }
  }

  void _toggleMainCategory(String category) {
    setState(() {
      selectedMain[category] = !(selectedMain[category] ?? false);
    });
  }

  void _toggleSubCategory(String category, String subCategory) {
    setState(() {
      selectedSub[category]![subCategory] =
          !(selectedSub[category]![subCategory] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, String>> animalList = animals.entries.toList();
    List<MapEntry<String, String>> firstRow = animalList.sublist(0, 4);
    List<MapEntry<String, String>> secondRow = animalList.sublist(4, 8);

    return ReportScreen(
      customWidget: Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              verticalSpace(22.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("نوع الحيوان",
                        style: CairoTextStyles.bold.copyWith(
                            fontSize: 28.sp, color: ColorsManager.secondGreen)),
                  ],
                ),
              ),
              verticalSpace(26.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: firstRow.map((entry) {
                        return GestureDetector(
                          onTap: () {
                            isSelected = !isSelected;
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: AnimalCard(
                              animalIcon: entry.value,
                              animalName: entry.key,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    verticalSpace(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: secondRow.map((entry) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: AnimalCard(
                            animalIcon: entry.value,
                            animalName: entry.key,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              verticalSpace(20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("تحديد الأصابة",
                            style: CairoTextStyles.bold.copyWith(
                                fontSize: 28.sp,
                                color: ColorsManager.secondGreen)),
                      ],
                    ),
                    verticalSpace(22.h),
                    Column(
                      children: diseaseCategories.keys.map((category) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            mainCategory(category),
                            if (selectedMain[category] == true)
                              ...subCategories(category),
                            verticalSpace(12.h),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              DiagnosticQuestions(),
              verticalSpace(20.h),
              UploadImageSection()
            ],
          ),
        ),
      ),
    );
  }

  Widget mainCategory(String category) {
    return GestureDetector(
      onTap: () => _toggleMainCategory(category),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            category,
            style: CairoTextStyles.bold.copyWith(
              fontSize: 18.sp,
              color: ColorsManager.secondGreen,
            ),
          ),
          horizontalSpace(8.w),
          customCheckBox(
            isChecked: selectedMain[category] ?? false,
            onTap: () => _toggleMainCategory(category),
            size: 42.w,
          ),
        ],
      ),
    );
  }

  List<Widget> subCategories(String category) {
    return diseaseCategories[category]!.map((subCategory) {
      return Padding(
        padding: EdgeInsets.only(right: 20.w, top: 16.h),
        child: GestureDetector(
          onTap: () => _toggleSubCategory(category, subCategory),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                subCategory,
                style: CairoTextStyles.medium.copyWith(
                  fontSize: 18.sp,
                  color: ColorsManager.secondGreen,
                ),
              ),
              horizontalSpace(8.w),
              customCheckBox(
                isChecked: selectedSub[category]![subCategory] ?? false,
                onTap: () => _toggleSubCategory(category, subCategory),
                size: 24.w,
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
