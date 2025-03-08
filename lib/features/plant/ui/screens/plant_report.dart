import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/functions.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/home/ui/home_background.dart';
import 'package:graduation_project/features/plant/data/model/plant_response.dart';
import 'package:graduation_project/features/plant/ui/widgets/guidlines_card.dart';
import 'package:graduation_project/features/plant/ui/widgets/progress.dart';

class PlantReport extends StatefulWidget {
  final Data? plantData;

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
                    verticalSpace(60.h),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 6.w),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 8.h,
                            left: 0.w,
                            right: 370.w,
                            child: Center(
                              child: Container(
                                width: 44.sp,
                                height: 44.sp,
                                decoration: BoxDecoration(
                                  color: ColorsManager.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8.h,
                            left: 370.w,
                            right: 0,
                            child: Center(
                              child: Container(
                                width: 44.sp,
                                height: 44.sp,
                                decoration: BoxDecoration(
                                  color: ColorsManager.mainGreen.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back,
                                    color: ColorsManager.white, size: 30.sp),
                                onPressed: () => context.pop(),
                              ),
                              IconButton(
                                icon: Icon(
                                  isTap ? Icons.star : Icons.star_border,
                                  color: ColorsManager.mainGreen,
                                  size: 35.sp,
                                ),
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
                    ),
                  ],
                ),
                Positioned(
                  top: 100.h,
                  left: 40.w,
                  child: SizedBox(
                    width: 180.w,
                    height: 200.h,
                    child: Image.network(
                      plantData.images != null && plantData.images!.length > 1
                          ? plantData.images![1].url!
                          : "https://via.placeholder.com/150",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    verticalSpace(150.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                plantData.name ?? 'غير معروف',
                                style: CairoTextStyles.black.copyWith(
                                    fontSize: 30.sp,
                                    color: ColorsManager.mainGreen),
                              ),
                              verticalSpace(20.h),
                              Text(
                                'فترة النمو',
                                style: CairoTextStyles.extraBold.copyWith(
                                    fontSize: 18.sp,
                                    color: ColorsManager.secondGreen),
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
                                    style: CairoTextStyles.bold.copyWith(
                                        color: ColorsManager.secondGreen,
                                        fontSize: 16.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(90.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InfoProgress(
                            title: "رطوبة الهواء",
                            icon: "assets/SVGs/plants/rotoba.png",
                            degree: translateReqRate(
                                (plantData.humidityRequirements)!),
                            stringDegree: (plantData.humidityRequirements)!),
                        InfoProgress(
                            title: "احتياج الماء",
                            icon: "assets/SVGs/plants/water.png",
                            degree: translateReqRate(
                                (plantData.waterRequirements)!),
                            stringDegree: (plantData.waterRequirements)!),
                        InfoProgress(
                            title: "احتياج الضوء",
                            icon: "assets/SVGs/plants/sun.png",
                            degree: translateReqRate(
                                (plantData.lightRequirements)!),
                            stringDegree: (plantData.lightRequirements)!),
                      ],
                    ),
                    verticalSpace(16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ': الوصف',
                          style: CairoTextStyles.extraBold.copyWith(
                              fontSize: 20.sp,
                              color: ColorsManager.secondGreen),
                        ),
                      ),
                    ),
                    verticalSpace(15.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: ExpandableText(
                        maxLines: 5,
                        plantData.description ?? "الوصف غير متوفر",
                        style: CairoTextStyles.semiBold.copyWith(
                            fontSize: 18.sp, color: ColorsManager.secondGreen),
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.rtl,
                        expandText: 'أقرأ المزيد',
                        animation: true,
                        animationDuration: Duration(seconds: 2),
                        linkStyle: CairoTextStyles.bold.copyWith(
                            fontSize: 18.sp, color: ColorsManager.secondGreen),
                      ),
                    ),
                    verticalSpace(22.h),
                    GuideLinesCards(
                        label: "موسم الزراعة",
                        description: plantData.season ?? 'غير متوفر',
                        iconImage: 'assets/SVGs/plants/Frame 163.png'),
                    GuideLinesCards(
                        label: "نوع التربة",
                        description: plantData.soilType ?? 'غير متوفر',
                        iconImage: 'assets/SVGs/plants/soil.png'),
                    GuideLinesCards(
                        label: "طريقة الزراعة",
                        description: plantData.plantingMethod ?? 'غير متوفر',
                        iconImage: 'assets/SVGs/plants/method.png'),
                    GuideLinesCards(
                        label: "المسافة بين النباتات",
                        description: plantData.spacing ?? 'غير متوفر',
                        iconImage: 'assets/SVGs/plants/space.png'),
                    GuideLinesCards(
                        label: "التسميد",
                        description: plantData.fertilizers ?? 'غير متوفر',
                        iconImage: 'assets/SVGs/plants/fertilizer.png'),
                    GuideLinesCards(
                        label: "الافات والامراض الشائعة",
                        description:
                            plantData.commonDiseases?.join(", ") ?? 'غير متوفر',
                        iconImage: 'assets/SVGs/plants/bacteria.png'),
                    GuideLinesCards(
                      label: "الاحتياجات الخاصة",
                      description: plantData.soilType ?? 'غير متوفر',
                      iconImage: 'assets/SVGs/plants/warning.png',
                      isRed: true,
                    ),
                    verticalSpace(75.h),
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
