import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/home/ui/home_background.dart';
import 'package:graduation_project/features/plant/ui/widgets/guidlines_card.dart';
import 'package:graduation_project/features/plant/ui/widgets/progress.dart';

class PlantReport extends StatefulWidget {
  @override
  State<PlantReport> createState() => _PlantReportState();
}

class _PlantReportState extends State<PlantReport> {
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    return HomeBackground(
      child: Expanded(
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
                              horizontalSpace(15.w),
                              GestureDetector(
                                onTap: () {
                                  context.pop();
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      ColorsManager.white.withOpacity(0.2),
                                  radius: 26.r,
                                  child: SvgPicture.asset(
                                    arrowBack,
                                    color: ColorsManager.white,
                                  ),
                                ),
                              ),
                              horizontalSpace(110.w),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              horizontalSpace(15.w),
                              GestureDetector(
                                onTap: () {
                                  isTap = !isTap;
                                  setState(() {});
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      ColorsManager.mainGreen.withOpacity(0.2),
                                  radius: 26.r,
                                  child: Icon(
                                    size: 35.sp,
                                    isTap ? Icons.star : Icons.star_border,
                                    color: ColorsManager.mainGreen,
                                  ),
                                ),
                              ),
                              horizontalSpace(30.w),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  // الصورة
                  Positioned(
                    top: 90.h,
                    left: 20.w,
                    child: SizedBox(
                      width: 200.w,
                      height: 220.h,
                      child: Image.asset('assets/SVGs/plants/plantimg.png'),
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
                                vertical: 22.h, horizontal: 40.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('القمح',
                                    style: CairoTextStyles.black.copyWith(
                                        fontSize: 30.sp,
                                        color: ColorsManager.mainGreen)),
                                Text('المصري',
                                    style: CairoTextStyles.black.copyWith(
                                        fontSize: 30.sp,
                                        color: ColorsManager.mainGreen)),
                                verticalSpace(18.h),
                                Text('فترة النمو',
                                    style: CairoTextStyles.extraBold.copyWith(
                                        fontSize: 18.sp,
                                        color: ColorsManager.secondGreen)),
                                verticalSpace(16.h),
                                Container(
                                  height: 40.h,
                                  width: 120.w,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: ColorsManager.greenWhite,
                                    borderRadius: BorderRadius.circular(
                                        20.r), // زوايا دائرية
                                  ),
                                  child: Center(
                                    child: Text(
                                      textDirection: TextDirection.rtl,
                                      "120 - 150 يوم",
                                      style: CairoTextStyles.bold.copyWith(
                                          color: ColorsManager.secondGreen,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(40.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InfoProgress(
                            title: "رطوبة الهواء",
                            degree: 50,
                            stringDegree: "متوسط",
                          ),
                          InfoProgress(
                            title: "احتياج الماء",
                            degree: 30,
                            stringDegree: "منخفض",
                          ),
                          InfoProgress(
                            title: "احتياج الضوء",
                            degree: 80,
                            stringDegree: "عالي",
                          ),
                        ],
                      ),
                      verticalSpace(16.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            child: Column(
                              children: [
                                ExpandableText(
                                  maxLines: 5,
                                  """
                              القمح هو نبات ذو أهمية عالمية ويعتبر من المحاصيل الأساسية التي تساهم في توفير الغذاء البشري. ينمو القمح في الأراضي الخصبة والري في المناطق ذات المناخ المعتدل. يتم زراعته في مصر بشكل رئيسي في الموسم الشتوي ويحتاج إلى حرارة معتدلة مع ضوء الشمس المباشر. يعتمد نجاح زراعته على توافر التربة الجيدة والمياه المناسبة، ويُزرع للحصول على حبوبه التي تُستخدم في صناعة الدقيق والخبز.
يتميز القمح بقدرته على التكيف مع ظروف مختلفة، ولكنه حساس للآفات والأمراض مثل الصدأ، ويتطلب مراقبة مستمرة للحفاظ على صحة المحصول.
                              """,
                                  style: CairoTextStyles.semiBold.copyWith(
                                      fontSize: 18.sp,
                                      color: ColorsManager.secondGreen),
                                  textAlign: TextAlign.justify,
                                  textDirection: TextDirection.rtl,
                                  expandText: 'أقرأ المزيد',
                                  animation: true,
                                  animationDuration: Duration(seconds: 2),
                                  linkStyle: CairoTextStyles.bold.copyWith(
                                      fontSize: 18.sp,
                                      color: ColorsManager.secondGreen),
                                ),
                                verticalSpace(22.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GuideLinesCards(),
                      verticalSpace(16.h),
                      GuideLinesCards(),
                      verticalSpace(16.h),
                      GuideLinesCards(),
                      verticalSpace(16.h),
                      GuideLinesCards(),
                      verticalSpace(16.h),
                      GuideLinesCards(),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
