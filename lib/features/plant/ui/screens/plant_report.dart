import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/home/ui/home_background.dart';
import 'package:graduation_project/features/plant/data/model/plant_response.dart';
import 'package:graduation_project/features/plant/ui/widgets/guidlines_card.dart';
import 'package:graduation_project/features/plant/ui/widgets/progress.dart';

class PlantReport extends StatefulWidget {
  final Data? plantData; // Nullable to handle potential null values

  const PlantReport({super.key, required this.plantData});

  @override
  State<PlantReport> createState() => _PlantReportState();
}

class _PlantReportState extends State<PlantReport> {
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    print("Plant Data: ${widget.plantData}"); // Debugging

    final plantData = widget.plantData;

    if (plantData == null) {
      return Scaffold(
        body: Center(
          child: Text(
            "حدث خطأ: بيانات النبات غير متوفرة",
            style: CairoTextStyles.extraBold.copyWith(
              fontSize: 20.sp,
              color: ColorsManager.secondGreen,
            ),
          ),
        ),
      );
    }

    return HomeBackground(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  top: 30.h,
                  child: Image.asset(
                    "assets/SVGs/home/cropBackGround.png",
                    width: 280.w,
                  ),
                ),
                Column(
                  children: [
                    verticalSpace(80.h),
                    Stack(
                      children: [
                        verticalSpace(75.h),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: ColorsManager.white, size: 30.sp),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(isTap ? Icons.star : Icons.star_border, color: ColorsManager.mainGreen, size: 35.sp),
                              onPressed: () {
                                setState(() {
                                  isTap = !isTap;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: 90.h,
                  left: 40.w,
                  child: SizedBox(
                    width: 180.w,
                    height: 200.h,
                    child: Image.network(
                      plantData.images?.isNotEmpty == true ? plantData.images!.first.url! : "https://via.placeholder.com/150",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    verticalSpace(150.h),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 40.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            plantData.name ?? 'غير معروف',
                            style: CairoTextStyles.black.copyWith(fontSize: 30.sp, color: ColorsManager.mainGreen),
                          ),
                          verticalSpace(10.h),
                          Text(
                            'فترة النمو بالايام',
                            style: CairoTextStyles.extraBold.copyWith(fontSize: 18.sp, color: ColorsManager.secondGreen),
                          ),
                          verticalSpace(16.h),
                          Container(
                            height: 40.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              color: ColorsManager.greenWhite,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                plantData.growthDuration ?? 'غير متوفر',
                                style: CairoTextStyles.bold.copyWith(color: ColorsManager.secondGreen, fontSize: 16.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InfoProgress(title: "رطوبة الهواء", degree: 50, stringDegree: "متوسط"),
                        InfoProgress(title: "احتياج الماء", degree: 30, stringDegree: "منخفض"),
                        InfoProgress(title: "احتياج الضوء", degree: 80, stringDegree: "عالي"),
                      ],
                    ),
                    verticalSpace(16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ': الوصف',
                          style: CairoTextStyles.extraBold.copyWith(fontSize: 20.sp, color: ColorsManager.secondGreen),
                        ),
                      ),
                    ),
                    verticalSpace(15.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: ExpandableText(
                        maxLines: 5,
                        plantData.description ?? "الوصف غير متوفر",
                        style: CairoTextStyles.semiBold.copyWith(fontSize: 18.sp, color: ColorsManager.secondGreen),
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.rtl,
                        expandText: 'أقرأ المزيد',
                        animation: true,
                        animationDuration: Duration(seconds: 2),
                        linkStyle: CairoTextStyles.bold.copyWith(fontSize: 18.sp, color: ColorsManager.secondGreen),
                      ),
                    ),
                    verticalSpace(22.h),
                    GuideLinesCards(label: "موسم الزراعة", description: plantData.season ?? 'غير متوفر', icon_image: 'assets/SVGs/plants/Frame 163.png'),
                    GuideLinesCards(label: "نوع التربة", description: plantData.soilType ?? 'غير متوفر', icon_image: 'assets/SVGs/plants/soil.png'),
                    GuideLinesCards(label: "طريقة الزراعة", description: plantData.plantingMethod ?? 'غير متوفر', icon_image: 'assets/SVGs/plants/method.png'),
                    GuideLinesCards(label: "المسافة بين النباتات", description: plantData.spacing ?? 'غير متوفر', icon_image: 'assets/SVGs/plants/space.png'),
                    GuideLinesCards(label: "التسميد", description: plantData.fertilizers ?? 'غير متوفر', icon_image: 'assets/SVGs/plants/fertilizer.png'),
                    GuideLinesCards(label: "الافات والامراض الشائعة", description: plantData.commonDiseases?.join(", ") ?? 'غير متوفر', icon_image: 'assets/SVGs/plants/bacteria.png'),
                    GuideLinesCards(label: "الاحتياجات الخاصة", description: plantData.soilType ?? 'غير متوفر', icon_image: 'assets/SVGs/plants/warning.png'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
