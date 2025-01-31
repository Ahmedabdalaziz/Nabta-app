import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/features/home/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:graduation_project/features/report/ui/widgets/animalCard.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 1,
        backgroundColor: ColorsManager.backGreen,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
        child: SvgPicture.asset('assets/SVGs/home/scan.svg'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/SVGs/home/مقاس موبايلي (1).png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const Center(
            child: Column(
              children: [
                AnimalCard(
                  animalIcon: cowIcon,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
