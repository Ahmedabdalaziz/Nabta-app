import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/features/home/ui/home_background.dart';

import '../../../../core/helper/functions.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/color.dart';
import '../../../../core/theming/style_manager.dart';
import '../../../../core/widgets/guidlines_card.dart';
import '../../../plant/ui/widgets/progress.dart';



class AnimalReport extends StatefulWidget {
  const AnimalReport({super.key});

  @override
  State<AnimalReport> createState() => _AnimalReportState();
}

class _AnimalReportState extends State<AnimalReport> {
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
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
                      "https://cdn.pixabay.com/photo/2018/01/29/07/11/flower-3115353_1280.jpg",
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
                                "نبات الجاردينيا",
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
                                    "3-4 أسابيع",
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
                    verticalSpace(190.h),

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
                        "الجاردينيا نبات استوائي دائم الخضرة معروف بأزهاره البيضاء العطرة وأوراقه الخضراء اللامعة. يحتاج إلى رعاية خاصة حيث يتطلب رطوبة عالية وتربة حمضية قليلاً. ينمو بشكل أفضل في الضوء الساطع غير المباشر ويحتاج إلى ري منتظم دون الإفراط في ذلك.",
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
                        description: "الربيع أو الخريف",
                        iconImage: 'assets/SVGs/plants/Frame 163.png'),
                    GuideLinesCards(
                        label: "نوع التربة",
                        description: "تربة حمضية جيدة التصريف",
                        iconImage: 'assets/SVGs/plants/soil.png'),
                    GuideLinesCards(
                        label: "طريقة الزراعة",
                        description: "عن طريق العقل أو البذور",
                        iconImage: 'assets/SVGs/plants/method.png'),
                    GuideLinesCards(
                        label: "المسافة بين النباتات",
                        description: "60-90 سم",
                        iconImage: 'assets/SVGs/plants/space.png'),
                    GuideLinesCards(
                        label: "التسميد",
                        description: "سماد حمضي كل أسبوعين خلال موسم النمو",
                        iconImage: 'assets/SVGs/plants/fertilizer.png'),
                    GuideLinesCards(
                        label: "الافات والامراض الشائعة",
                        description: "المن، البق الدقيقي، العناكب، اصفرار الأوراق",
                        iconImage: 'assets/SVGs/plants/bacteria.png'),
                    GuideLinesCards(
                      label: "الاحتياجات الخاصة",
                      description: "تحتاج إلى رطوبة عالية وتجنب التيارات الهوائية الباردة",
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