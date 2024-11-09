import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/color.dart';

import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> imagePaths = [
    'assets/SVGs/onboarding/1onboarding.png',
    'assets/SVGs/onboarding/1onboarding.png',
    'assets/SVGs/onboarding/1onboarding.png',
  ];

  final List<String> titles = [
    'فحص النبات',
    'استشارة مع الخبراء',
    'ابدأ الآن',
  ];

  final List<String> descriptions = [
    'قم بفحص النبات وتعرف على الأمراض التي قد تصيبه.',
    'احصل على النصائح من الخبراء للحفاظ على صحة نباتك.',
    'اكتشف المزيد عن المزايا المتاحة لك الآن.',
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_currentPage < imagePaths.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: imagePaths.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) => OnboardingPage(
              imagePath: imagePaths[index],
              title: titles[index],
              description: descriptions[index],
            ),
          ),
          Positioned(
            bottom: 80.h,
            left: 20.w,
            child: _currentPage == 0
                ? TextButton(
                    onPressed: _nextPage,
                    child: Text(
                      'تخطي',
                      style: TextStyle(
                        color: ColorsManager.secondGreen,
                        fontSize: 16.sp,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            bottom: 30.h,
            left: 20.w,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color:
                    _currentPage == 0 ? Colors.grey : ColorsManager.secondGreen,
              ),
              onPressed: _previousPage,
            ),
          ),
          Positioned(
            bottom: 30.h,
            right: 20.w,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                color: ColorsManager.secondGreen,
              ),
              onPressed: _nextPage,
            ),
          ),
        ],
      ),
    );
  }
}
