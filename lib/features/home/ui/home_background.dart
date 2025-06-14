import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/features/home/ui/widgets/custom_bottom_nav_bar.dart';

import '../../../core/theming/color.dart';

class HomeBackground extends StatefulWidget {
  final Widget child;
  final int currentIndex ;

  const HomeBackground({super.key, required this.child, this.currentIndex = 0});

  @override
  State<HomeBackground> createState() => _HomeBackgroundState();
}

class _HomeBackgroundState extends State<HomeBackground> {
  int _currentIndex = 0;

  final List<String> _routes = [
    Routing.homeScreen,
    Routing.plantScreen,
    Routing.chatScreen,
    Routing.firstReportScreen,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBody: true,
          backgroundColor: ColorsManager.white,
          floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () {},
            elevation: 0,
            backgroundColor: ColorsManager.backGreen.withOpacity(0),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              if (index < _routes.length &&
                  _routes[index] != ModalRoute.of(context)?.settings.name) {
                setState(() {
                  _currentIndex = index;
                });
                context.pushNamed(_routes[index]);
              }
            },
          ),
          body: Stack(
            children: [
              Image.asset(
                "assets/SVGs/home/مقاس موبايلي (1).png",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              SafeArea(
                child: widget.child,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 35.h,
          right: MediaQuery.of(context).size.width / 2 - 34.w,
          child: FloatingActionButton(
            onPressed: () {
              context.pushNamed(Routing.cameraScreen); // Camera navigation
            },
            elevation: 3,
            backgroundColor: ColorsManager.backGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: SvgPicture.asset('assets/SVGs/home/scan.svg'),
          ),
        ),
      ],
    );
  }
}