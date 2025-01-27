import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/home/ui/widgets/bottomSection.dart';
import 'package:graduation_project/features/home/ui/widgets/bottomSectionWithoutClip.dart';
import 'package:graduation_project/features/home/ui/widgets/infoSection.dart';
import 'package:graduation_project/features/home/ui/widgets/longCardInfo.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    //list for the special icons ya 3m 7amoooooooooooo
    final List<IconData> icons = [
      HugeIcons.strokeRoundedHome05,
      //const FaIcon(FontAwesomeIcons.seedling).icon!,
      HugeIcons.strokeRoundedPlant01,
      HugeIcons.strokeRoundedMessage01,
      HugeIcons.strokeRoundedMenu01,
    ];
    // index for the info cards about weather
    int animationIdx = 0;
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: ColorsManager.white,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              elevation: 1,
              backgroundColor: const Color(0xff70AB81),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r)),
              child: SvgPicture.asset('assets/SVGs/home/scan.svg'),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            //navigation bar
            bottomNavigationBar: AnimatedBottomNavigationBar(
              icons: icons,
              activeIndex: animationIdx,
              onTap: (index) => setState(() => animationIdx = index),
              gapLocation: GapLocation.center,
              leftCornerRadius: 25.r,
              rightCornerRadius: 25.r,
              backgroundColor: ColorsManager.lightWhite,
              activeColor: ColorsManager.mainGreen,
              inactiveColor: ColorsManager.secondGreen,
              height: 62.h,
              borderWidth: 424.w,
              notchSmoothness: NotchSmoothness.smoothEdge,
              iconSize: 35.sp,
            ),
            body: Stack(
              children: [
                Image.asset(
                  "assets/SVGs/home/مقاس موبايلي (1).png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Column(
                  children: [
                    verticalSpace(56.h),
                    //الايقونة والصورة اللي فوق خالص
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Stack(
                        children: [
                          Positioned(
                            left: -4.w,
                              child: SvgPicture.asset('assets/SVGs/home/Ellipse 33.svg')
                          ),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.bell,
                                color: ColorsManager.mainGreen,
                                size: 31,
                              ),
                              const Spacer(),
                              Text(
                                  'حمو',
                                  style: CairoTextStyles.bold.copyWith(fontSize: 20,color: ColorsManager.mainGreen)
                              ),
                              Text(
                                '  , أهلا',
                                style: CairoTextStyles.bold.copyWith(fontSize: 20,color: ColorsManager.black),
                              ),
                              horizontalSpace(16.w),
                              SizedBox(
                                width: 45.w,
                                height: 45.h,
                                child:  CircleAvatar(
                                  radius: 5.r,
                                  backgroundColor: ColorsManager.mainGreen,
                                  child: CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor: ColorsManager.moreWhite,
                                    child: Image.asset(
                                            'assets/SVGs/home/test_avatar.png',
                                            fit: BoxFit.cover,
                                           ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(27.h),
                    // كرت الطقس
                    SizedBox(
                      height: 150.h, // Adjust height for the card + indicator
                      child: Column(
                        children: [
                          SizedBox(
                            height: 133.5.h,
                            width: 392.w, // Height for the PageView
                            child: PageView(
                              controller: _pageController,
                              children: const [
                                InfoOne(),
                                InfoTwo(),
                                InfoThree(),
                              ],
                            ),
                          ),
                          verticalSpace(10.h),
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: 3,
                            effect: ExpandingDotsEffect(
                                dotHeight: 8.h,
                                dotWidth: 8.w,
                                activeDotColor: ColorsManager.secondGreen,
                                dotColor: ColorsManager.secondGreen
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(11.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.9.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InfoSection(
                                imgPath: 'assets/SVGs/home/kemi_ka_0.75.png',
                                leftPadding: 34.w,
                                topPadding: 38.h,
                                cardLabel: 'الكيماويات',
                              ),
                              InfoSection(
                                imgPath: 'assets/SVGs/home/cow_0.75.png',
                                leftPadding: 23.w,
                                topPadding: 45.h,
                                cardLabel: 'الحيوانات',
                              ),
                              InfoSection(
                                imgPath: 'assets/SVGs/home/npta_0.75.png',
                                leftPadding: 35.w,
                                topPadding: 45.h,
                                cardLabel: 'النباتات',
                              ),
                            ],
                          ),
                          verticalSpace(20.h),
                          Container(
                            width: double.infinity.w,
                            height: 128.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffE0EAE4),
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: Stack(
                              children: [
                                Image.asset('assets/SVGs/home/ادوات_1.5.png'),
                                const LongCardInfo(
                                  cardLabel: 'السوق الزراعي',
                                  cardHint: '!بيع واشتري منتجاتك الزراعية بسهولة',
                                  cardDescription: 'اضف منتجاتك وحدد السعر المناسب لك وتصف المنتجات المضافة حديثا',
                                )
                              ],
                            ),
                          ),
                          verticalSpace(20.h),
                          Container(
                            width: double.infinity.w,
                            height: 128.h,
                            child: Stack(
                                fit: StackFit.expand,
                                children:
                                [
                                  Image.asset(
                                    'assets/SVGs/home/card_background2.png',
                                    fit: BoxFit.fill,
                                  ),
                                  Positioned(
                                    left: 5.w,
                                    child: Image.asset('assets/SVGs/home/Rectangle 75.png',),
                                  ),
                                  Positioned(
                                    bottom: 2.h,
                                    left: 6.w,
                                    child: Image.asset('assets/SVGs/home/Group 111.png'),
                                  ),
                                  Positioned(
                                    bottom: 5.h,
                                    left: 6.w,
                                    child:  const Icon(Icons.star_border,color: ColorsManager.mainGreen,),
                                  ),
                                  const LongCardInfo(
                                    cardLabel: 'السوق الزراعي',
                                    cardHint: '!بيع واشتري منتجاتك الزراعية بسهولة',
                                    cardDescription: 'اضف منتجاتك وحدد السعر المناسب لك وتصف المنتجات المضافة حديثا',
                                  ),
                                ]

                            ),

                          ),
                          verticalSpace(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const BottomSections(
                                imgPath: 'assets/SVGs/home/Group 149.png',
                                sectionLabel: 'أمراض الحيوانات',
                              ),
                             horizontalSpace(16.w),
                              const BottomSectionWithouCliprrect(
                                imgPath: 'assets/SVGs/home/Group 150.png',
                                sectionLabel: 'ابلاع بيطري',
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}







class InfoOne extends StatelessWidget {
  const InfoOne({super.key});



  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Image.asset('assets/SVGs/home/Group 129.png', fit: BoxFit.fitWidth),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 12.64.h, right: 7.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //verticalSpace(12.h),
                Text(
                  'صافي',
                  style: CairoTextStyles.bold.copyWith(fontSize: 13.sp,color: ColorsManager.secondGreen),
                ),

                Text(
                  'الامطار : %0',
                  style: CairoTextStyles.bold.copyWith(fontSize: 13.sp,color: ColorsManager.secondGreen),
                ),
                Text(
                  'الرطوبة : %0',
                  style: CairoTextStyles.bold.copyWith(fontSize: 13.sp,color: ColorsManager.secondGreen),
                ),
                Text(
                  'الرياح : 18 كم/س',
                  style: CairoTextStyles.bold.copyWith(fontSize: 13.sp,color: ColorsManager.secondGreen),
                ),
              ],
            ),
          ),
          horizontalSpace(8.5.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '27\u00B0',
                style: CairoTextStyles.bold.copyWith(fontSize: 65.sp,color: ColorsManager.mainGreen),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 0, right: 15.w, left: 0, bottom: 3.h),
                    child: Text(
                      'مصر - اسيوط',
                      style: CairoTextStyles.bold.copyWith(fontSize: 16.sp,color: ColorsManager.mainGreen),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    ]);
  }
}

class InfoTwo extends StatelessWidget {
  const InfoTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Image.asset('assets/SVGs/home/weather2.png', fit: BoxFit.fitWidth),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 12.64.h, right: 7.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               //verticalSpace(12.h),
                Text(
                  'صافي',
                  style: CairoTextStyles.bold.copyWith(fontSize: 13.sp,color: ColorsManager.secondGreen),
                ),
                Text(
                  'الامطار : %0',
                  style: CairoTextStyles.bold.copyWith(fontSize: 13.sp,color: ColorsManager.secondGreen),
                ),
                Text(
                  'الرطوبة : %0',
                  style: CairoTextStyles.bold.copyWith(fontSize: 13.sp,color: ColorsManager.secondGreen),
                ),
                Text(
                  'الرياح : 18 كم/س',
                  style: CairoTextStyles.bold.copyWith(fontSize: 13.sp,color: ColorsManager.secondGreen),
                ),
              ],
            ),
          ),
          horizontalSpace(8.5.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '27\u00B0',
                style: CairoTextStyles.bold.copyWith(fontSize: 65.sp,color: ColorsManager.mainGreen),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 0, right: 15.w, left: 0, bottom: 3.h),
                    child: Text(
                      'مصر - اسيوط',
                      style: CairoTextStyles.bold.copyWith(fontSize: 16.sp,color: ColorsManager.mainGreen),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    ]);
  }
}

class InfoThree extends StatelessWidget {
  const InfoThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Image.asset('assets/SVGs/home/weather3.png', fit: BoxFit.fitWidth),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 12.64.h, right: 7.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //verticalSpace(12.h),
                Text(
                  'صافي',
                  style: CairoTextStyles.bold.copyWith(fontSize: 13.sp,color: ColorsManager.secondGreen),
                ),
                Text(
                  'الامطار : %0',
                  style: CairoTextStyles.bold.copyWith(fontSize: 13.sp,color: ColorsManager.secondGreen),

                ),
                Text(
                  'الرطوبة : %0',
                  style: CairoTextStyles.bold.copyWith(fontSize: 13.sp,color: ColorsManager.secondGreen),

                ),
                Text(
                  'الرياح : 18 كم/س',
                  style: CairoTextStyles.bold.copyWith(fontSize: 13.sp,color: ColorsManager.secondGreen),

                ),
              ],
            ),
          ),
          horizontalSpace(8.5.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '27\u00B0',
                style: CairoTextStyles.bold.copyWith(fontSize: 65.sp,color: ColorsManager.mainGreen),

              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 0, right: 15.w, left: 0, bottom: 3.h),
                    child: Text(
                      'مصر - اسيوط',
                      style: CairoTextStyles.bold.copyWith(fontSize: 16.sp,color: ColorsManager.mainGreen),

                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    ]);
  }
}
