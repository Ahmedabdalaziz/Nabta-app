import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/home/ui/home_background.dart';
import 'package:graduation_project/features/plant/logic/plant_cubit.dart';
import 'package:graduation_project/features/plant/ui/widgets/guidlines_card.dart';
import 'package:graduation_project/features/plant/ui/widgets/progress.dart';

class PlantReport extends StatefulWidget {
  const PlantReport({super.key});

  @override
  State<PlantReport> createState() => _PlantReportState();
}

class _PlantReportState extends State<PlantReport> {
  bool isTap = false;

  @override
  void initState() {
    super.initState();
    context.read<PlantCubit>().fetchPlants(); // استدعاء البيانات عند تحميل الشاشة
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlantCubit, PlantState>(
      listener: (context, state) {
        if (state is PlantFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("حدث خطأ: ${state.errorMessage}")),
          );
        }
      },
      builder: (context, state) {
        if (state is plantLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PlantSuccess) {
          final plantData = state.plantResponse.data?.first;
          if (plantData == null) {
            return const Center(child: Text("لا توجد بيانات متاحة"));
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
                                  horizontalSpace(15.w),
                                  GestureDetector(
                                    onTap: () {
                                      context.pop();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: ColorsManager.white.withOpacity(0.2),
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
                                      setState(() {
                                        isTap = !isTap;
                                      });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: ColorsManager.mainGreen.withOpacity(0.2),
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
                      Positioned(
                        top: 90.h,
                        left: 40.w,
                        child: SizedBox(
                          width: 180.w,
                          height: 200.h,
                          child: Image.network(plantData.images![1].url.toString()),
                        ),
                      ),
                      Column(
                        children: [
                          verticalSpace(150.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 40.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      plantData.name ?? 'غير معروف',
                                      style: CairoTextStyles.black.copyWith(
                                        fontSize: 30.sp,
                                        color: ColorsManager.mainGreen,
                                      ),
                                    ),
                                    Text(
                                      'المصري',
                                      style: CairoTextStyles.black.copyWith(
                                        fontSize: 30.sp,
                                        color: ColorsManager.mainGreen,
                                      ),
                                    ),
                                    verticalSpace(18.h),
                                    Text(
                                      'فترة النمو',
                                      style: CairoTextStyles.extraBold.copyWith(
                                        fontSize: 18.sp,
                                        color: ColorsManager.secondGreen,
                                      ),
                                    ),
                                    verticalSpace(16.h),
                                    Container(
                                      height: 40.h,
                                      width: 120.w,
                                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: ColorsManager.greenWhite,
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      child: Center(
                                        child: Text(
                                          textDirection: TextDirection.rtl,
                                          "120 - 150 يوم",
                                          style: CairoTextStyles.bold.copyWith(
                                            color: ColorsManager.secondGreen,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                                      color: ColorsManager.secondGreen,
                                    ),
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
                                      "القمح هو نبات ذو أهمية عالمية ويعتبر من المحاصيل الأساسية...",
                                      style: CairoTextStyles.semiBold.copyWith(
                                        fontSize: 18.sp,
                                        color: ColorsManager.secondGreen,
                                      ),
                                      textAlign: TextAlign.justify,
                                      textDirection: TextDirection.rtl,
                                      expandText: 'أقرأ المزيد',
                                      animation: true,
                                      animationDuration: Duration(seconds: 2),
                                      linkStyle: CairoTextStyles.bold.copyWith(
                                        fontSize: 18.sp,
                                        color: ColorsManager.secondGreen,
                                      ),
                                    ),
                                    verticalSpace(22.h),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ...List.generate(5, (index) => Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: GuideLinesCards(),
                          )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text("حدث خطأ غير متوقع"));
        }
      },
    );
  }
}
