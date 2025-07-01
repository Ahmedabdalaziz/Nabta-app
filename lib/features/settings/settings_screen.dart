import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/features/home/ui/home_background.dart';

import '../../core/helper/strings.dart';
import '../../core/routing/routing.dart';
import '../../core/theming/color.dart';
import '../../core/theming/style_manager.dart';
import '../home/ui/widgets/custom_bottom_nav_bar.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return HomeBackground(
        child: Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              verticalSpace(47.5.h),
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
                        'الاعدادات',
                        style: CairoTextStyles.bold.copyWith(
                            color: ColorsManager.mainGreen, fontSize: 28.sp),
                      ),
                    ],
                  ),
                ],
              ),
              verticalSpace(25.h),
              Stack(
                children: [
                  Container(
                    width: 408.w,
                    height: 82.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.whiteWithGreen,
                      borderRadius: BorderRadius.circular(26.r),
                    ),
                    child: SettingTab(
                      iconPath: "assets/SVGs/settings/profileIcon.png",
                      title: "اعدادات الحساب",
                    ),
                  )
                ],
              ),
              verticalSpace(30.h),
              Stack(
                children: [
                  Container(
                      width: 408.w,
                      height: 240.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.whiteWithGreen,
                        borderRadius: BorderRadius.circular(26.r),
                      ),
                      child: Column(
                        children: [
                          SettingTab(
                              title: "تغيير اللغة",
                              iconPath:
                                  "assets/SVGs/settings/languageIcon.png"),
                          Divider(
                            color: ColorsManager.secondGreen,
                            thickness: 1,
                            endIndent: 30,
                          ),
                          SettingTab(
                              title: "تغيير المظهر",
                              iconPath:
                                  "assets/SVGs/settings/darkModeIcon.png"),
                          Divider(
                            color: ColorsManager.secondGreen,
                            thickness: 1,
                            endIndent: 30,
                          ),
                          SettingTab(
                              title: "تغيير وحدة القياس",
                              iconPath:
                                  "assets/SVGs/settings/metricIcon.png"),
                        ],
                      ))
                ],
              ),
              verticalSpace(30.h),
              Stack(
                children: [
                  Container(
                    width: 408.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.whiteWithGreen,
                      borderRadius: BorderRadius.circular(26.r),
                    ),
                    child: Column(
                      children: [
                        SettingTab(
                            title: "حذف سجل الدردشات",
                            iconPath: "assets/SVGs/settings/deleteChatIcon.png"),
                        Divider(
                          color: ColorsManager.secondGreen,
                          thickness: 1,
                          endIndent: 30,
                        ),
                        SettingTab(
                            title: "حذف المفضلة",
                            iconPath: "assets/SVGs/settings/deleteFavIcon.png"),
                      ],
                    ),
                  )
                ],
              ),
              verticalSpace(30.h),
              Stack(
                children: [
                  Container(
                    width: 408.w,
                    height: 72.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.whiteWithGreen,
                      borderRadius: BorderRadius.circular(26.r),
                    ),
                    child: Column(
                      children: [
                        SettingTab(
                            title: "التحكم بالاشعارات",
                            iconPath: "assets/SVGs/settings/manageNotficationIcon.png"),
                      ],
                    ),
                  )
                ],
              ),
              verticalSpace(30.h),
              Stack(
                children: [
                  Container(
                    width: 408.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.whiteWithGreen,
                      borderRadius: BorderRadius.circular(26.r),
                    ),
                    child: Column(
                      children: [
                        SettingTab(
                          title: "حذف الحساب",
                          iconPath: "assets/SVGs/settings/deleteAccountIcon.png",
                          isRed: true,
                        ),
                        Divider(
                          color: ColorsManager.secondGreen,
                          thickness: 1,
                          endIndent: 30,
                        ),
                        SettingTab(
                            title: "تسجيل الخروج",
                            iconPath: "assets/SVGs/settings/logOutIcon.png"),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ))
      ],
    ));
  }
}

class SettingTab extends StatelessWidget {
  final String title;
  final String iconPath;
  final bool isRed;

  const SettingTab({
    super.key,
    required this.title,
    required this.iconPath,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isRed ? ColorsManager.red : ColorsManager.secondGreen;

    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: color,
          ),
        ),
        Spacer(
          flex: 10,
        ),
        // RSizedBox.horizontal(187.w),
        Text(
          title,
          style: CairoTextStyles.bold.copyWith(
            color: color,
            fontSize: 18.sp,
          ),
        ),
        Spacer(
          flex: 1,
        ),
        // horizontalSpace(20.w),
        SizedBox(
          width: 30.w,
          height: 30.h,
          child: Image.asset(
            iconPath,
            color: color, // Optional: if you want the icon to also change color
          ),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
