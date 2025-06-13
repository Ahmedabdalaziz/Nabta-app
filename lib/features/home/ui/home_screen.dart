import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/functions.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/will_pop.dart';
import 'package:graduation_project/features/home/data/remot/model/user_data_request.dart';
import 'package:graduation_project/features/home/logic/user_data_cubit.dart';
import 'package:graduation_project/features/home/ui/home_background.dart';
import 'package:graduation_project/features/home/ui/widgets/bottomSection.dart';
import 'package:graduation_project/features/home/ui/widgets/bottomSectionWithoutClip.dart';
import 'package:graduation_project/features/home/ui/widgets/infoSection.dart';
import 'package:graduation_project/features/home/ui/widgets/longCardInfo.dart';
import 'package:graduation_project/features/weather/logic/weather_cubit.dart';
import 'package:graduation_project/features/weather/weather_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    requestPermissions();
    context.read<WeatherCubit>().fetchWeather("Asyut");
    context.read<UserDataCubit>().fetchAndSaveData();
  }

  @override
  Widget build(BuildContext context) {
    return ExitConfirmation(
      child: HomeBackground(
        child: Stack(
          children: [
            Image.asset(
              "assets/SVGs/home/مقاس موبايلي (1).png",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Column(
              children: [
                verticalSpace(10.h),
                BlocBuilder<UserDataCubit, UserDataState>(
                  builder: (context, state) {
                    String userName = ' ';
                    String imagePath = 'assets/SVGs/home/test_avatar.png';

                    if (state is UserDataSuccess) {
                      UserDataResponse userDataResponse = state.userData;

                      if (userDataResponse.userData.username != null &&
                          userDataResponse.userData.username!.isNotEmpty) {
                        userName = userDataResponse.userData.username!
                            .split(' ')
                            .first;
                        ;
                      }

                      if (userDataResponse.userData.image != null &&
                          userDataResponse.userData.image!.isNotEmpty) {
                        imagePath = userDataResponse.userData.image!;
                      }
                    }

                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Stack(
                          children: [
                            Positioned(
                                left: -4.w,
                                child: SvgPicture.asset(
                                    'assets/SVGs/home/Ellipse 33.svg')),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.bell,
                                  color: ColorsManager.mainGreen,
                                  size: 38.sp,
                                ),
                                const Spacer(),
                                Text(
                                  userName,
                                  style: CairoTextStyles.bold.copyWith(
                                      fontSize: 24.sp,
                                      color: ColorsManager.mainGreen),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  ' , أهلا',
                                  style: CairoTextStyles.bold.copyWith(
                                      fontSize: 24.sp,
                                      color: ColorsManager.black),
                                ),
                                horizontalSpace(16.w),
                                SizedBox(
                                  width: 45.w,
                                  height: 45.h,
                                  child: CircleAvatar(
                                    radius: 22.5.r,
                                    backgroundColor: ColorsManager.mainGreen,
                                    child: CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor: ColorsManager.moreWhite,
                                      child: ClipOval(
                                        child: Image.asset(
                                          imagePath,
                                          fit: BoxFit.cover,
                                          width: 40.w,
                                          height: 40.h,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.network(
                                              imagePath,
                                              width: 40.w,
                                              height: 40.h,
                                              fit: BoxFit.contain,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                verticalSpace(27.h),
                ///////////////////// كرت الطقس/////////////////////
                BlocBuilder<WeatherCubit, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherLoading) {
                      return SizedBox(
                        height: 150.h,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: ColorsManager.mainGreen,
                        )),
                      );
                    } else if (state is WeatherLoaded) {
                      final weatherData = state.weatherResponse.days;
                      return SizedBox(
                        height: 150.h,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 133.5.h,
                              width: 400.w,
                              child: PageView(
                                controller: _pageController,
                                children: weatherData.map((day) {
                                  return WeatherCard(
                                    condition: day.conditions,
                                    humidity: day.humidity,
                                    windSpeed: day.windspeed,
                                    temperature: day.temp,
                                    location: 'اسيوط-مصر',
                                  );
                                }).toList(),
                              ),
                            ),
                            verticalSpace(10.h),
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: weatherData.length,
                              effect: ExpandingDotsEffect(
                                dotHeight: 8.h,
                                dotWidth: 8.w,
                                activeDotColor: ColorsManager.secondGreen,
                                dotColor: ColorsManager.secondGreen,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is WeatherError) {
                      return SizedBox(
                        height: 150.h,
                        child: Center(child: Text("Error: ${state.message}")),
                      );
                    } else {
                      return SizedBox(
                        height: 150.h,
                        child: const Center(child: Text("No data available.")),
                      );
                    }
                  },
                ),
                verticalSpace(11.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23.9.w),
                  child: Column(
                    children: [
                      // plants with animal and chemical cards
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InfoSection(
                            imgPath: 'assets/SVGs/home/kemia_home.png',
                            leftPadding: 8.w,
                            topPadding: 18.h,
                            cardLabel: 'الكيماويات',
                          ),
                          InfoSection(
                            imgPath: 'assets/SVGs/home/cow_on_home.png',
                            leftPadding: 12.w,
                            topPadding: 28.h,
                            cardLabel: 'الحيوانات',
                          ),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(Routing.plantScreen);
                            },
                            child: InfoSection(
                              imgPath: 'assets/SVGs/home/plants_onhome.png',
                              leftPadding: 12.w,
                              topPadding: 20.h,
                              cardLabel: 'النباتات',
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(20.h),
                      ///////////////////// soke zera3yy /////////////////////
                      Container(
                        width: double.infinity.w,
                        height: 128.h,
                        decoration: BoxDecoration(
                          color: ColorsManager.greenWhite,
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0.sp),
                              child: Image.asset('assets/SVGs/home/tools.png'),
                            ),
                            const LongCardInfo(
                              cardLabel: 'السوق الزراعي',
                              cardHint: '!بيع واشتري منتجاتك الزراعية بسهولة',
                              cardDescription:
                                  'اضف منتجاتك وحدد السعر المناسب لك وتصف المنتجات المضافة حديثا',
                            )
                          ],
                        ),
                      ),
                      verticalSpace(20.h),
                      SizedBox(
                        width: double.infinity.w,
                        height: 128.h,
                        child: Stack(fit: StackFit.expand, children: [
                          Image.asset(
                            'assets/SVGs/home/card_background2.png',
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            left: 0.w,
                            top: 4.h,
                            child: Image.asset(
                              'assets/SVGs/home/small_water.png',
                              width: 80.w,
                              height: 80.h,
                            ),
                          ),
                          Positioned(
                            bottom: 2.h,
                            left: 4.w,
                            child:
                                Image.asset('assets/SVGs/home/Group 111.png'),
                          ),
                          Positioned(
                            bottom: 5.h,
                            left: 6.w,
                            child: const Icon(Icons.star_border,
                                color: ColorsManager.mainGreen),
                          ),
                          const LongCardInfo(
                            cardLabel: 'نشرة الزراعة',
                            cardHint: ' !الري تعلن خطة ترشيد استهلاك المياه',
                            cardDescription:
                                'أطلقت وزارة الري حملة لترشيد استخدام المياه في الزراعة والصناعة، مع التركيز على تقنيات الري الحديث لتحسين الكفاءة وتقليل الفاقد.',
                          ),
                        ]),
                      ),
                      verticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const BottomSections(
                            imgPath: 'assets/SVGs/home/disease.png',
                            sectionLabel: 'أمراض الحيوانات',
                          ),
                          horizontalSpace(16.w),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(Routing.firstReportScreen);
                            },
                            child: const BottomSectionWithouCliprrect(
                              imgPath: 'assets/SVGs/home/report_on_home.png',
                              sectionLabel: 'إبلاغ بيطري',
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
