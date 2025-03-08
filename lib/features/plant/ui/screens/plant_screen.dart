import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/dark_Custom_text_field.dart';
import 'package:graduation_project/features/home/ui/home_background.dart';
import 'package:graduation_project/features/plant/data/model/plant_response.dart';
import 'package:graduation_project/features/plant/logic/plant_cubit.dart';
import 'package:graduation_project/features/plant/ui/widgets/available_stock.dart';

class PlantsScreen extends StatefulWidget {
  const PlantsScreen({super.key});

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlantCubit>().fetchPlants();
  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    return BlocConsumer<PlantCubit, PlantState>(
      listener: (context, state) {
        if (state is PlantFailed) {
          Center(child: Text("حدث خطأ: ${state.errorMessage}"));
        }
      },
      builder: (context, state) {
        if (state is plantLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorsManager.mainGreen,
            ),
          );
        } else if (state is PlantSuccess) {
          final plantData = state.plantResponse.data;
          // نباتات غذائية
          final foodPlants = plantData
              ?.where((plant) => plant.category == 'النباتات الغذائية')
              .toList();
          // نباتات صناعية
          final industrialPlants = plantData
              ?.where((plant) => plant.category == 'النباتات الصناعية')
              .toList();
          // خضراوات
          final vegetablePlants = plantData
              ?.where((plant) => plant.category == 'الخضروات')
              .toList();

          if (plantData == null) {
            return const Center(child: Text("لا توجد بيانات متاحة"));
          }
          return HomeBackground(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Column(
                        children: [
                          verticalSpace(40.h),
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
                                      backgroundColor: ColorsManager.mainGreen
                                          .withOpacity(0.1),
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
                          verticalSpace(16.h),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: GridView.count(
                                crossAxisCount: 3,
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                crossAxisSpacing: 16.w,
                                mainAxisSpacing: 8.h,
                                childAspectRatio: 1.17.sp,
                                children: _buildGridItemsFood(
                                    foodPlants!, context)),
                          ),
                          verticalSpace(24.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('نباتات صناعية',
                                  style: CairoTextStyles.bold.copyWith(
                                      fontSize: 20.sp,
                                      color: ColorsManager.secondGreen)),
                            ],
                          ),
                          verticalSpace(16.h),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: GridView.count(
                                crossAxisCount: 3,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisSpacing: 16.w,
                                mainAxisSpacing: 8.h,
                                childAspectRatio: 1.17.sp,
                                children: _buildGridItemsIndustrial(
                                    industrialPlants!, context)),
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
                          verticalSpace(16.h),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: GridView.count(
                                crossAxisCount: 3,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisSpacing: 16.w,
                                mainAxisSpacing: 8.h,
                                childAspectRatio: 1.17.sp,
                                children: _buildGridItemsVegitables(
                                    vegetablePlants!, context)),
                          ),
                          verticalSpace(64.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text("حدث خطأ غير متوقع"));
        }
      },
    );
  }
}

// فنكشن لعرض الكروت بتاعت النباتات
List<Widget> _buildGridItemsFood(List<Data> itemsGrid, BuildContext context) {
  return itemsGrid.map((plant) {
    return GestureDetector(
      onTap: () {
        print("Navigating with plant data: ${plant.name}");
        context.pushNamed(Routing.plantReport, arguments: plant);
      },
      child: AvailableStock(
        imgPath: plant.images?.isNotEmpty == true
            ? plant.images!.first.url!
            : 'default_image.png',
        label: plant.name ?? 'Unknown',
        leftPositioned: 30,
        topPositioned: 30,
      ),
    );
  }).toList();
}

List<Widget> _buildGridItemsIndustrial(List<Data> itemsGrid, BuildContext context) {
  return itemsGrid.map((plant) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routing.plantReport, arguments: plant);
      },
      child: AvailableStock(
        imgPath: plant.images?.isNotEmpty == true
            ? plant.images!.first.url!
            : 'default_image.png',
        label: plant.name ?? 'Unknown',
        leftPositioned: 30,
        topPositioned: 30,
      ),
    );
  }).toList();
}

List<Widget> _buildGridItemsVegitables(List<Data> itemsGrid, BuildContext context) {
  return itemsGrid.map((plant) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routing.plantReport, arguments: plant);
      },
      child: AvailableStock(
        imgPath: plant.images?.isNotEmpty == true
            ? plant.images!.first.url!
            : 'default_image.png',
        label: plant.name ?? 'Unknown',
        leftPositioned: 33,
        topPositioned: 25,
      ),
    );
  }).toList();
}
