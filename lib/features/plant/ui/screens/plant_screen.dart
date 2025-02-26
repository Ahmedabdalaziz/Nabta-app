import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/dark_Custom_text_field.dart';
import 'package:graduation_project/features/home/ui/home_background.dart';
import 'package:graduation_project/features/plant/data/model/plant_response.dart';
import 'package:graduation_project/features/plant/logic/plant_cubit.dart';
import 'package:graduation_project/features/plant/ui/widgets/available_stock.dart';
import 'package:graduation_project/features/plant/ui/widgets/non_available_stock.dart';

class PlantsScreen extends StatefulWidget {
  const PlantsScreen({super.key});

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {


  @override
 void initState()
  {
    super.initState();
    context.read<PlantCubit>().fetchPlants(); // استدعاء البيانات عند تحميل الشاشة

  }


  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    return BlocConsumer<PlantCubit, PlantState>(
  listener: (context, state) {
    if(state is PlantFailed){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ: ${state.errorMessage}")),
      );
    }
  },
  builder: (context, state) {
    if(state is plantLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else if(state is PlantSuccess) {
      final plantData = state.plantResponse.data;
      // نباتات غذائية
      final foodPlants = plantData?.where((plant)=> plant.category == 'النباتات الغذائية').toList();
      // نباتات صناعية
      final industrialPlants = plantData?.where((plant)=> plant.category == 'النباتات الغذائية').toList();
      // خضراوات
      final vegetablePlants = plantData?.where((plant)=> plant.category == 'النباتات الغذائية').toList();

      if (plantData == null) {
        return const Center(child: Text("لا توجد بيانات متاحة"));
      }
      return HomeBackground(
        child: Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                children: [
                  verticalSpace(67.h),
                  Stack(
                    children: [
                      // el top of el screen
                      Row(
                        children: [
                          horizontalSpace(16.w),
                          GestureDetector(
                            onTap: () {
                              context.pop();
                            },
                            child: CircleAvatar(
                              backgroundColor:
                              ColorsManager.mainGreen.withOpacity(0.1),
                              radius: 26.r,
                              child: SvgPicture.asset(arrowBack),
                            ),
                          ),
                          horizontalSpace(130.w),
                          Text(
                            'النباتات',
                            style: CairoTextStyles.bold.copyWith(
                                color: ColorsManager.mainGreen,
                                fontSize: 28.sp),
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
                      SizedBox(
                        height: 60.h,
                        width: 400.w,
                        child: DarkCustomTextField(
                          textColor: ColorsManager.mainGreen,
                          icon: Icon(
                            Icons.search_sharp,
                            color: ColorsManager.secondGreen,
                            size: 40.sp,
                          ),
                          borderCircular: 50.r,
                          labelText: 'بحث',
                          fillColor: Color(0xffE4EBE7),
                          hintTextFontSize: 25.sp,
                          borderWides: 1,
                        ),
                      ),
                      verticalSpace(26.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('نباتات غذائية',
                              style: CairoTextStyles.bold.copyWith(
                                  fontSize: 20.sp,
                                  color: ColorsManager.secondGreen)),
                        ],
                      ),
                      verticalSpace(12.h),
                      Column(
                        children: [
                          // nabatat for eating
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     AvailableStock(
                          //       imgPath: 'assets/SVGs/plants/corn2.png',
                          //       label: 'ذره',
                          //       leftPositioned: 25,
                          //       topPositioned: 20,
                          //     ),
                          //     AvailableStock(
                          //       imgPath: 'assets/SVGs/plants/rice.png',
                          //       label: 'أرز',
                          //       leftPositioned: 25,
                          //       topPositioned: 20,
                          //     ),
                          //     GestureDetector(
                          //       onTap: () {
                          //         context.pushNamed(Routing.plantReport);
                          //       },
                          //       child: AvailableStock(
                          //         imgPath: 'assets/SVGs/plants/flower.png',
                          //         label: 'قمح',
                          //         leftPositioned: 28,
                          //         topPositioned: 20,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // verticalSpace(10.h),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     NonAvailableStock(),
                          //     NonAvailableStock(),
                          //     AvailableStock(
                          //       imgPath: 'assets/SVGs/plants/potato.png',
                          //       label: 'بطاطس',
                          //       leftPositioned: 25,
                          //       topPositioned: 20,
                          //     )
                          //   ],
                          // ),
                          GridView.count(
                            crossAxisCount: 3,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(), // Disable scrolling inside the grid
                               crossAxisSpacing: 16.w, // Horizontal spacing between items
                               mainAxisSpacing: 8.h, // Vertical spacing between items
                               childAspectRatio: 1.31.sp, // Adjust the aspect ratio of items
                              padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 0.h),

                              children: _buildGridItems(foodPlants!)
                          )
                        ],
                      ),
                      verticalSpace(24.h),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('نباتات صناعية',
                          style: CairoTextStyles.bold.copyWith(
                              fontSize: 20.sp,
                              color: ColorsManager.secondGreen)),
                    ],
                  ),
                  verticalSpace(8.h),
                  // npatat for manefacture
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NonAvailableStock(),
                      AvailableStock(
                        imgPath: 'assets/SVGs/plants/cane.png',
                        label: 'قصب',
                        boxW: 90,
                        boxH: 90,
                        leftPositioned: 32,
                        topPositioned: 30,
                      ),
                      AvailableStock(
                        imgPath: 'assets/SVGs/plants/cotton.png',
                        label: 'قطن',
                        boxH: 95,
                        boxW: 95,
                        leftPositioned: 25,
                        topPositioned: 25,
                      ),
                    ],
                  ),
                  verticalSpace(24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('خضراوات',
                          style: CairoTextStyles.bold.copyWith(
                              fontSize: 20.sp,
                              color: ColorsManager.secondGreen)),
                    ],
                  ),
                  verticalSpace(8.h),
                  // vegetables
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NonAvailableStock(),
                      NonAvailableStock(),
                      AvailableStock(
                        imgPath: 'assets/SVGs/plants/onion.png',
                        label: 'بصل',
                        leftPositioned: 25,
                        topPositioned: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }else {
      return const Center(child: Text("حدث خطأ غير متوقع"));
    }
  },
);
  }
}


// فنكشن لعرض الكروت بتاعت النباتات
List<Widget> _buildGridItems( List<Data> itemsGrid) {
  List<Widget> items = [];
  for (int i = 0; i < itemsGrid.length ; i++) {
    items.add(
      AvailableStock(
        imgPath: 'assets/SVGs/plants/corn2.png',
        label: 'أرز',
        leftPositioned: 25,
        topPositioned: 20,
      ),
    );
  }
  // items.add(NonAvailableStock());
  // items.add(NonAvailableStock());
  return items;
}