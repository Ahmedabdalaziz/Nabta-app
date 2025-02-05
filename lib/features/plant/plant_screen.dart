import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/dark_Custom_text_field.dart';
import 'package:graduation_project/features/home/ui/widgets/custom_bottom_nav_bar.dart';

class PlantsScreen extends StatefulWidget
{
  const PlantsScreen({super.key});

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  @override
  Widget build(BuildContext context)
  {
    int _currentIndex = 0;
    return Scaffold(

      body: Stack(
        fit: StackFit.expand,
        children: [
          //the background
          Image.asset(
            'assets/SVGs/plants/background.png',
            fit: BoxFit.cover,
          ),
          // main column holds the whole screen
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Column(
              children: [
                verticalSpace(67.h),
                Stack(
                  children: [
                    // el top of el screen
                    Positioned(
                        right: 352.w,
                        child: SvgPicture.asset(
                            'assets/SVGs/home/Ellipse 33.svg')
                    ),
                    Row(
                      children: [
                        horizontalSpace(16.w),
                        Icon(
                          Icons.arrow_back_rounded,
                          color: ColorsManager.mainGreen,
                          size: 45.sp,

                        ),
                        horizontalSpace(135.5.w),
                        Text(
                          'النباتات',
                          style: CairoTextStyles.bold.copyWith(color: ColorsManager.mainGreen,fontSize: 24.sp),
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpace(24.h),
                // el kawa2m
                Column(
                  children: [
                    // el search bar
                    DarkCustomTextField(
                      textColor: ColorsManager.mainGreen,
                      icon: Icon(Icons.search_rounded,color: ColorsManager.secondGreen,size: 40.sp,),
                      borderCircular: 50.r,
                      labelText: 'بحث',
                      fillColor: Color(0xffE4EBE7),

                    ),
                    verticalSpace(26.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            'نباتات غذائية',
                            style: CairoTextStyles.bold.copyWith(fontSize: 20.sp,color:ColorsManager.secondGreen)
                        ),
                      ],

                    ),
                    verticalSpace(12.h),
                    Column(
                      children: [
                        // nabatat for eating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AvailableStock(img_path: 'assets/SVGs/plants/corn2.png', label: 'ذره', left_positioned: 25,top_positioned: 20,),
                            AvailableStock(img_path: 'assets/SVGs/plants/rice.png', label: 'أرز', left_positioned: 25,top_positioned: 20,),
                            AvailableStock(img_path: 'assets/SVGs/plants/flower.png', label: 'قمح',left_positioned: 28,top_positioned: 20,),
                          ],
                        ),
                        verticalSpace(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NonAvailableStock(),
                            NonAvailableStock(),
                            AvailableStock(img_path: 'assets/SVGs/plants/potato.png', label: 'بطاطس', left_positioned: 25,top_positioned: 20,)
                          ],
                        ),
                      ],
                    ),
                    verticalSpace(24.h),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        'نباتات صناعية',
                        style: CairoTextStyles.bold.copyWith(fontSize: 20.sp,color:ColorsManager.secondGreen)
                    ),
                  ],

                ),
                verticalSpace(8.h),
                // npatat for manefacture
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NonAvailableStock(),
                    AvailableStock(img_path: 'assets/SVGs/plants/cane.png', label: 'قصب',box_w: 90,box_h: 90,left_positioned: 32,top_positioned: 30,),
                    AvailableStock(img_path: 'assets/SVGs/plants/cotton.png', label: 'قطن',box_h: 95,box_w: 95,left_positioned: 25,top_positioned: 25,),
                  ],
                ),
                verticalSpace(24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        'خضراوات',
                        style: CairoTextStyles.bold.copyWith(fontSize: 20.sp,color:ColorsManager.secondGreen)
                    ),
                  ],
                ),
                verticalSpace(8.h),
                // vegetables
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NonAvailableStock(),
                    NonAvailableStock(),
                    AvailableStock(img_path: 'assets/SVGs/plants/onion.png', label: 'بصل',left_positioned: 25,top_positioned: 20,)

                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}

class NonAvailableStock extends StatelessWidget {
  const NonAvailableStock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 120.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: ColorsManager.greenWhite,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/SVGs/plants/soonPotato.png',fit: BoxFit.fitWidth,),
        ],
      ),
    );
  }
}

class AvailableStock extends StatelessWidget {
  final String img_path;
  final String label;
  final int box_h ;
  final int box_w ;
  final int top_positioned ;
  final int left_positioned ;
  const AvailableStock({
    super.key,
    required this.img_path,
    required this.label,
    this.box_h = 100,
    this.box_w = 100,
    required this.top_positioned,
    required this.left_positioned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 120.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: ColorsManager.greenWhite,
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.h,left: 12.w),
            child: Text(
                label,
                style: CairoTextStyles.bold.copyWith(fontSize: 20.sp,color:ColorsManager.secondGreen)
            ),
          ),
          Positioned(
            left: left_positioned.w,//25
            top: top_positioned.h,//20
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.sp),
              child: Container(
                  height: box_h.h,
                  width: box_w.w,
                  child: Image.asset(img_path)),
            ),
          ),
        ],
      ),
    );
  }
}
