import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/color.dart'; // Make sure this import is correct

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dot1Animation;
  late Animation<double> _dot2Animation;
  late Animation<double> _dot3Animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    _dot1Animation = Tween<double>(begin: 0, end: 8.h).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.23, curve: Curves.easeInOut),
      ),
    );
    _dot2Animation = Tween<double>(begin: 0, end: 8.h).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.23, 0.45, curve: Curves.easeInOut),
      ),
    );
    _dot3Animation = Tween<double>(begin: 0, end: 8.h).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.50, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 8.h,
          bottom: 8.h,
          left: 0,
          right: 50.w,
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: ColorsManager.mainGreen.withOpacity(0.2),
          // Match bot message color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDot(_dot1Animation),
            SizedBox(width: 4.w),
            _buildDot(_dot2Animation),
            SizedBox(width: 4.w),
            _buildDot(_dot3Animation),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -animation.value),
          child: Container(
            width: 8.w,
            height: 8.h,
            decoration: const BoxDecoration(
              color:ColorsManager.mainGreen ,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
