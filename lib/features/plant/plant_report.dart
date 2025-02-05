import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/crops/ui/widgets/backgroung_crops.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PlantReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية والعناصر الأخرى
          backgroundCrops(),
          Column(
            children: [
              verticalSpace(80.h),
              Stack(
                children: [
                  Positioned(
                    right: 382.w,
                    top: 3.h,
                    child: SvgPicture.asset(
                        'assets/SVGs/plants/Ellipse 33.svg'),
                  ),
                  Positioned(
                    left: 370.w,
                    top: 6.h,
                    child: SvgPicture.asset(
                        'assets/SVGs/plants/Rectangle 76.svg'),
                  ),
                  Row(
                    children: [
                      horizontalSpace(16.w),
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: SizedBox(
                          height: 60.h,
                          width: 40.w,
                          child: Icon(Icons.arrow_back_rounded,
                              color: ColorsManager.moreWhite, size: 35.sp),
                        ),
                      ),
                      horizontalSpace(388.w),
                      GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          height: 60.h,
                          width: 40.w,
                          child: Icon(Icons.star_border_outlined,
                              color: ColorsManager.mainGreen, size: 35.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // الصورة
          Positioned(
            top: 100.h, // عدل حسب الحاجة
            left: 20.w, // عدل حسب الحاجة
            child: SizedBox(
              width: 200.w, // عرض الصورة حسب المقاس المناسب
              height: 200.h, // ارتفاع الصورة حسب المقاس المناسب
              child: Image.asset('assets/SVGs/plants/plantimg.png'),
            ),
          ),
          Column(
            children: [
              verticalSpace(200.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 22.h,horizontal: 40.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'القمح',
                          style: CairoTextStyles.black.copyWith(fontSize: 30.sp,color: ColorsManager.mainGreen)
                        ),
                        Text(
                          'المصري',
                          style: CairoTextStyles.black.copyWith(fontSize: 30.sp,color: ColorsManager.mainGreen)
                        ),
                        verticalSpace(16.h),
                        Text(
                            'فترة النمو',
                            style: CairoTextStyles.extraBold.copyWith(fontSize: 18.sp,color: ColorsManager.secondGreen)
                        ),
                        verticalSpace(8.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: ColorsManager.greenWhite, // اللون الأخضر الفاتح
                            borderRadius: BorderRadius.circular(20.r), // زوايا دائرية
                          ),
                          child: Text(
                            "120 - 150 يوم",
                            style: CairoTextStyles.bold.copyWith(color: ColorsManager.secondGreen,fontSize: 16.sp),
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
                InfoProgress(),
                InfoProgress(),
                InfoProgress(),
              ],
            ),
            verticalSpace(16.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 24.w),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        ':الوصف',
                        style: CairoTextStyles.extraBold.copyWith(fontSize: 20.sp, color: ColorsManager.secondGreen),
                      ),
                    ),
                  ),
                  verticalSpace(15.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    //margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'يعد القمح من أكثر المحاصيل الزراعية انتشاراً، حيث يُزرع في مناطق متعددة نظرًا لتحمله لمختلف الظروف البيئية تيست تيستتيستتيستتيستتيستتيستتيستتيستتيستتيستتيستتيستتيستتيستتيست...',
                      style: CairoTextStyles.semiBold.copyWith(fontSize: 16.sp, color: ColorsManager.mainGreen),
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      textDirection: TextDirection.rtl, // حل مشكلة انعكاس النص
                    ),
                  ),
                ],
              ),
              GuideLinesCards()
            ],
          )
        ],
      ),
    );
  }
}

class GuideLinesCards extends StatelessWidget {
  const GuideLinesCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 408.w,
      height: 100.h,
      child:Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/SVGs/plants/Frame 162.png',fit: BoxFit.fill,),
          Positioned(
            right: 10.w,
            top: 25.h,
            child: SizedBox(
                height: 48.h,
                width: 48.w,
                child: Image.asset('assets/SVGs/plants/Frame 163.png')),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: 8.h,left: 150.w),
                    child: Text(
                      'موسم الزراعة',
                      style: CairoTextStyles.bold.copyWith(fontSize: 16.sp, color: ColorsManager.secondGreen),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(right: 70.w),
                    child: SizedBox(
                      width: 322.w,
                      height: 48.h,
                      child: Text(
                        'تربة خصبة جيدة التصريف، ويفضل أن تكون طينية أو طينية مختلطة بالرمل.',
                        style: CairoTextStyles.semiBold.copyWith(fontSize: 16.sp, color: ColorsManager.secondGreen),
                        textAlign: TextAlign.justify,
                        //softWrap: true,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ],
              ),

            ],
          )
        ],
      ),
    );
  }
}

class InfoProgress extends StatelessWidget {
  const InfoProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'رطوبة الهواء',
          style: CairoTextStyles.extraBold.copyWith(fontSize: 18.sp,color: ColorsManager.secondGreen),
        ),
        verticalSpace(35.h),
        CircularPercentIndicator(
          radius: 45.r,
          lineWidth: 10.sp,
          percent: 0.25,
          progressColor: ColorsManager.mainGreen,
          center: SvgPicture.asset('assets/SVGs/plants/rotoba.svg',),
          circularStrokeCap: CircularStrokeCap.round,
        ),
        verticalSpace(20.h),
        Text(
          'منخفض',
          style: CairoTextStyles.bold.copyWith(fontSize: 18.sp,color: ColorsManager.mainGreen),
        ),

      ],
    );
  }
}
