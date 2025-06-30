
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocConsumer, ReadContext;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart' show verticalSpace, horizontalSpace;
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart' show ColorsManager;
import 'package:graduation_project/core/theming/style_manager.dart' show CairoTextStyles;
import 'package:graduation_project/core/widgets/available_stock.dart' show AvailableStock;
import 'package:graduation_project/core/widgets/dark_Custom_text_field.dart' show DarkCustomTextField;
import 'package:graduation_project/features/animal/data/model/animal_response.dart';
import 'package:graduation_project/features/home/ui/home_background.dart' show HomeBackground;

import '../../../../core/routing/routing.dart';
import '../../logic/animal_cubit.dart';

class AnimalScreen extends StatefulWidget {
  const AnimalScreen({Key? key}) : super(key: key);

  @override
  State<AnimalScreen> createState() => _AnimalScreenState();
}

class _AnimalScreenState extends State<AnimalScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AnimalCubit>().fetchAnimals(); // استدعاء البيانات عند تحميل الشاشة
  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0; // This variable is not used
    return BlocConsumer<AnimalCubit, AnimalState>(
      listener: (context, state) {
        if (state is AnimalFaild) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("حدث خطأ: ${state.errorMessage}")),
          );
        }
      },
      builder: (context, state) {
        if (state is AnimalLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: ColorsManager.white,
                color: ColorsManager.mainGreen,
              ),
            ),
          );
        } else if (state is AnimalSuccess) {
          final AnimalData = state.animalResponse.data;
          //  حيوانات مزرعة
          final farmAnimals = AnimalData
              ?.where((animal) => animal.animalType == 'حيوانات المزارع الصغيرة')
              .toList();
          // دواجن
          final poultry = AnimalData
              ?.where((animal) => animal.animalType == 'دواجن')
              .toList();
          // ماشية
          final cattle = AnimalData
              ?.where((animal) => animal.animalType == 'ماشية')
              .toList();

          // حيوانات النقل
          final transportAnimals = AnimalData
              ?.where((animal) => animal.animalType == 'حيوانات النقل')
              .toList();

          if (AnimalData == null) {
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
                                      backgroundColor: ColorsManager.mainGreen
                                          .withOpacity(0.1),
                                      radius: 26.r,
                                      child: SvgPicture.asset(arrowBack),
                                    ),
                                  ),
                                  horizontalSpace(130.w),
                                  Text(
                                    'الحيوانات',
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
                                  Text('الماشية',
                                      style: CairoTextStyles.bold.copyWith(
                                          fontSize: 20.sp,
                                          color: ColorsManager.secondGreen)),
                                ],
                              ),
                              verticalSpace(12.h),
                              Column(
                                children: [
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: GridView.count(
                                      crossAxisCount: 3,
                                      shrinkWrap: true,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      // Disable scrolling inside the grid
                                      crossAxisSpacing: 16.w,
                                      // Horizontal spacing between items
                                      mainAxisSpacing: 8.h,
                                      // Vertical spacing between items
                                      childAspectRatio: 1.31.sp,
                                      // Adjust the aspect ratio of items
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 0.h),
                                      children: _buildGridItemsCattle(
                                          cattle!, context),
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(24.h),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('الدواجن',
                                  style: CairoTextStyles.bold.copyWith(
                                      fontSize: 20.sp,
                                      color: ColorsManager.secondGreen)),
                            ],
                          ),
                          verticalSpace(8.h),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              // Disable scrolling inside the grid
                              crossAxisSpacing: 16.w,
                              // Horizontal spacing between items
                              mainAxisSpacing: 8.h,
                              // Vertical spacing between items
                              childAspectRatio: 1.19.sp,
                              // Adjust the aspect ratio of items
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 0.h),
                              children: _buildGridItemsPoultry(
                                  poultry!, context),
                            ),
                          ),
                          verticalSpace(24.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('حيوانات النقل',
                                  style: CairoTextStyles.bold.copyWith(
                                      fontSize: 20.sp,
                                      color: ColorsManager.secondGreen)),
                            ],
                          ),
                          verticalSpace(8.h),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              // Disable scrolling inside the grid
                              crossAxisSpacing: 16.w,
                              // Horizontal spacing between items
                              mainAxisSpacing: 8.h,
                              // Vertical spacing between items
                              childAspectRatio: 1.19.sp,
                              // Adjust the aspect ratio of items
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 0.h),
                              children: _buildGridItemsTransportAnimals(
                                  transportAnimals!, context),
                            ),
                          ),
                          verticalSpace(24.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('حيوانات المزارع الصغيرة',
                                  style: CairoTextStyles.bold.copyWith(
                                      fontSize: 20.sp,
                                      color: ColorsManager.secondGreen)),
                            ],
                          ),
                          verticalSpace(8.h),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              // Disable scrolling inside the grid
                              crossAxisSpacing: 16.w,
                              // Horizontal spacing between items
                              mainAxisSpacing: 8.h,
                              // Vertical spacing between items
                              childAspectRatio: 1.19.sp,
                              // Adjust the aspect ratio of items
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 0.h),
                              children: _buildGridItemsFarmAnimals(
                                  farmAnimals!, context),
                            ),
                          ),
                          verticalSpace(36.h),

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

List<Widget> _buildGridItemsCattle(List<Animal> itemsGrid, BuildContext context) {
  return itemsGrid.map((animal) {
    return GestureDetector(
      onTap: () {
        print("Navigating with plant data: ${animal.commonName}");
        context.pushNamed(Routing.animalReport, arguments: animal);
      },
      child: AvailableStock(
        // Increase boxH and boxW here
        boxH: 150, // Example: Increased from 125
        boxW: 130, // Example: Added a value
        imgPath: animal.image?.isNotEmpty == true
            ? animal.image!.first
            : 'default_image.png',
        label: animal.commonName ?? 'Unknown',
        leftPositioned: 35,
        topPositioned: 15,
      ),
    );
  }).toList();
}

List<Widget> _buildGridItemsPoultry(
    List<Animal> itemsGrid, BuildContext context) {
  return itemsGrid.map((animal) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routing.animalReport, arguments: animal);
      },
      child: AvailableStock(
        // Increase boxH and boxW here
        boxH: 150, // Example: Increased from 125
        boxW: 130, // Example: Added a value
        imgPath: animal.image?.isNotEmpty == true
            ? animal.image!.first
            : 'default_image.png',
        label: animal.commonName ?? 'Unknown',
        leftPositioned: 35,
        topPositioned: 20,
      ),
    );
  }).toList();
}

List<Widget> _buildGridItemsTransportAnimals(
    List<Animal> itemsGrid, BuildContext context) {
  return itemsGrid.map((animal) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routing.animalReport, arguments: animal);
      },
      child: AvailableStock(
        // Increase boxH and boxW here
        boxH: 150, // Example: Increased from 150
        boxW: 130, // Example: Added a value
        imgPath: animal.image?.isNotEmpty == true
            ? animal.image!.first
            : 'default_image.png',
        label: animal.commonName ?? 'Unknown',
        leftPositioned: 33,
        topPositioned: 20,
      ),
    );
  }).toList();
}

List<Widget> _buildGridItemsFarmAnimals(
    List<Animal> itemsGrid, BuildContext context) {
  return itemsGrid.map((animal) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routing.animalReport, arguments: animal);
      },
      child: AvailableStock(
        // Increase boxH and boxW here
        boxH: 150, // Example: Increased from 160
        boxW: 130, // Example: Added a value
        imgPath: animal.image?.isNotEmpty == true
            ? animal.image!.first
            : 'default_image.png',
        label: animal.commonName ?? 'Unknown',
        leftPositioned: 33,
        topPositioned: 20,
      ),
    );
  }).toList();
}