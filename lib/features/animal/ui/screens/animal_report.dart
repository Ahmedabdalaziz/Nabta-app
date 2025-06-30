import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/features/animal/ui/widgets/pointed_card.dart'
    show PointedGuideLineCard;
import 'package:graduation_project/features/home/ui/home_background.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/color.dart';
import '../../../../core/theming/style_manager.dart';
import '../../../../core/widgets/guidlines_card.dart';
import '../../data/model/animal_response.dart';

class AnimalReport extends StatefulWidget {
  final Animal? animalData;

  const AnimalReport({super.key, this.animalData});

  @override
  State<AnimalReport> createState() => _AnimalReportState();
}

class _AnimalReportState extends State<AnimalReport> {
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    final animalData = widget.animalData;
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
                    width: 233.w,
                  ),
                ),
                Column(
                  children: [
                    verticalSpace(60.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
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
                                  color:
                                      ColorsManager.mainGreen.withOpacity(0.2),
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
                  top: 90.h,
                  left: 20.w,
                  child: SizedBox(
                      width: 230.w,
                      height: 220.h,
                      child: Image.network(
                        animalData!.image![1],
                        fit: BoxFit.cover,
                      )),
                ),
                Positioned(
                  top: 350.h,
                  left: 20.w,
                  child: Container(
                    height: 40.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: ColorsManager.greenWhite,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Center(
                      child: Text(
                        "العمر : ${animalData.age}",
                        style: CairoTextStyles.bold.copyWith(
                            color: ColorsManager.secondGreen, fontSize: 16.sp),
                      ),
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
                                animalData.commonName ?? "غير معروف",
                                style: CairoTextStyles.black.copyWith(
                                    fontSize: 30.sp,
                                    color: ColorsManager.mainGreen),
                              ),
                              verticalSpace(4.h),
                              Text(
                                animalData.scientificName ?? " غير معروف",
                                style: CairoTextStyles.extraBold.copyWith(
                                    fontSize: 20.sp,
                                    color: ColorsManager.mainGreen),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Column(
                            children: [
                              Text("احتياج المياه",
                                  style: CairoTextStyles.bold.copyWith(
                                      fontSize: 14.sp,
                                      color: ColorsManager.secondGreen)),
                              verticalSpace(4.h),
                              Container(
                                  width: 77.5.w,
                                  height: 89.h,
                                  child: Image.asset(
                                      "assets/SVGs/animals/waterNeed.png")),
                              verticalSpace(4.h),
                              Text(
                                "15 - 20 K",
                                style: CairoTextStyles.extraBold.copyWith(
                                    fontSize: 14.sp,
                                    color: ColorsManager.secondGreen),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Column(
                            children: [
                              Text("احتياج الطعام",
                                  style: CairoTextStyles.bold.copyWith(
                                      fontSize: 14.sp,
                                      color: ColorsManager.secondGreen)),
                              verticalSpace(4.h),
                              Container(
                                  width: 77.5.w,
                                  height: 89.h,
                                  child: Image.asset(
                                      "assets/SVGs/animals/foodNeed.png")),
                              verticalSpace(4.h),
                              Text(
                                "15 - 20 K",
                                style: CairoTextStyles.extraBold.copyWith(
                                    fontSize: 14.sp,
                                    color: ColorsManager.secondGreen),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(20.h),
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
                        animalData.description!,
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
                    verticalSpace(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          ":التغذية والمياه",
                          style: CairoTextStyles.extraBold.copyWith(
                              fontSize: 20.sp,
                              color: ColorsManager.secondGreen),
                        )
                      ],
                    ),
                    verticalSpace(8.h),
                    GuideLinesCards(
                        label: "النظام الغذائي",
                        description: animalData.foodNeeds!,
                        iconImage: 'assets/SVGs/animals/feedAlerts.png'),
                    PointedGuideLineCard(
                      label: "انواع الاعلاف المناسبة",
                      points: animalData.nutrition!.suitableFeeds!,
                      iconImage: 'assets/SVGs/animals/feedAlerts.png',
                    ),
                    PointedGuideLineCard(
                      label: "كمية الاكل",
                      iconImage: "assets/SVGs/animals/feedAlerts.png",
                      points: animalData.nutrition!.dailyFoodIntake!,
                    ),
                    PointedGuideLineCard(
                      label: "احتياج المياه",
                      iconImage: "assets/SVGs/animals/feedAlerts.png",
                      points: animalData.nutrition!.dailyWaterNeeds!,
                    ),
                    PointedGuideLineCard(
                      label: "احتياج المياه",
                      iconImage: "assets/SVGs/animals/feedAlerts.png",
                      points: animalData.nutrition!.forbiddenFoods!,
                      isRed: true,
                    ),
                    verticalSpace(16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "دورة الحياة والتكاثر",
                            style: CairoTextStyles.extraBold.copyWith(
                                fontSize: 20.sp,
                                color: ColorsManager.secondGreen),
                          )
                        ],
                      ),
                    ),
                    GuideLinesCards(
                        label: "متوسط العمر",
                        description: animalData.lifeCycle!.averageLifespan!,
                        iconImage: 'assets/SVGs/animals/lifeCycleAlert.png'),
                    GuideLinesCards(
                        label: "سن البلوغ الجنسي",
                        description: animalData.lifeCycle!.sexualMaturityAge!,
                        iconImage: 'assets/SVGs/animals/lifeCycleAlert.png'),
                    GuideLinesCards(
                        label: "مدة الحمل",
                        description: animalData.lifeCycle!.gestationPeriod!,
                        iconImage: 'assets/SVGs/animals/lifeCycleAlert.png'),
                    PointedGuideLineCard(
                      label: "عدد الصغار عند الولادة",
                      iconImage: "assets/SVGs/animals/lifeCycleAlert.png",
                      points: animalData.lifeCycle!.offspringPerBirth!,
                    ),
                    verticalSpace(16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "الامراض والمشاكل الصحية",
                            style: CairoTextStyles.extraBold.copyWith(
                                fontSize: 20.sp,
                                color: ColorsManager.secondGreen),
                          )
                        ],
                      ),
                    ),
                    PointedGuideLineCard(
                      label: "الامراض الشائعة",
                      iconImage: "assets/SVGs/animals/diseasAlert.png",
                      points: animalData.health!.nameArabic!,
                    ),
                    GuideLinesCards(
                        label: "الاعراض",
                        description: animalData.health!.symptoms!,
                        iconImage: 'assets/SVGs/animals/diseasAlert.png'),
                    GuideLinesCards(
                        label: "العلاج",
                        description: animalData.health!.treatment!,
                        iconImage: 'assets/SVGs/animals/diseasAlert.png'),
                    GuideLinesCards(
                        label: "الوقاية",
                        description: animalData.health!.prevention!,
                        iconImage: 'assets/SVGs/animals/diseasAlert.png'),
                    verticalSpace(16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "العناية والرعاية بالصحة",
                            style: CairoTextStyles.extraBold.copyWith(
                                fontSize: 20.sp,
                                color: ColorsManager.secondGreen),
                          )
                        ],
                      ),
                    ),
                    PointedGuideLineCard(
                      label: "البيئة المناسبة",
                      iconImage: "assets/SVGs/animals/careAlert.png",
                      points: animalData.care!.environment!,
                    ),
                    GuideLinesCards(
                        label: "النظافة الشخصية",
                        description: animalData.care!.hygiene!,
                        iconImage: 'assets/SVGs/animals/careAlert.png'),
                    GuideLinesCards(
                      label: "في الحالات الطارئة",
                      description: animalData.care!.emergencyCases!,
                      iconImage: 'assets/SVGs/animals/careAlert.png',
                      isRed: true,
                    ),
                    verticalSpace(16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "الانتاج والاستخدام",
                            style: CairoTextStyles.extraBold.copyWith(
                                fontSize: 20.sp,
                                color: ColorsManager.secondGreen),
                          )
                        ],
                      ),
                    ),
                    PointedGuideLineCard(
                        label: "الفوايد",
                        points: animalData.production!.benefits!,
                        iconImage: 'assets/SVGs/animals/productionAlert.png'),
                    PointedGuideLineCard(
                        label: "تحسين الانتاج",
                        points: animalData.production!.optimizationMethods!,
                        iconImage: 'assets/SVGs/animals/productionAlert.png'),
                    verticalSpace(16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "سلوك الحيوان والتفاعل",
                            style: CairoTextStyles.extraBold.copyWith(
                                fontSize: 20.sp,
                                color: ColorsManager.secondGreen),
                          )
                        ],
                      ),
                    ),
                    GuideLinesCards(
                      label: "طبيعة السلوك",
                      description: animalData.behavior!.nature!,
                      iconImage: 'assets/SVGs/animals/behaviorAlert.png',
                    ),
                    GuideLinesCards(
                      label: "التعامل الصحيح",
                      description: animalData.behavior!.handlingGuidelines!,
                      iconImage: 'assets/SVGs/animals/behaviorAlert.png',
                    ),
                    PointedGuideLineCard(
                      label: "علامات الراحة",
                      points: animalData.behavior!.comfortSigns!,
                      iconImage: 'assets/SVGs/animals/behaviorAlert.png',
                    ),
                    PointedGuideLineCard(
                      label: "علامات التوتر",
                      points: animalData.behavior!.stressSigns!,
                      iconImage: 'assets/SVGs/animals/behaviorAlert.png',
                      isRed: true,
                    ),
                    verticalSpace(16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "معلومات اضافية",
                            style: CairoTextStyles.extraBold.copyWith(
                                fontSize: 20.sp,
                                color: ColorsManager.secondGreen),
                          )
                        ],
                      ),
                    ),
                    GuideLinesCards(
                      label: "مصائح الخبراء",
                      description: animalData.additionalInfo!.expertTips!,
                      iconImage: 'assets/SVGs/animals/infoAlert.png',
                    ),
                    PointedGuideLineCard(
                        label: "حقائق",
                        points: animalData.additionalInfo!.interestingFacts!,
                        iconImage: 'assets/SVGs/animals/infoAlert.png'),
                    verticalSpace(16.h),
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
