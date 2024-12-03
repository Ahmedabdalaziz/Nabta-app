import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';

class CustomModalBottomSheet extends StatelessWidget {
  final Widget child;
  final double height;

  const CustomModalBottomSheet({
    Key? key,
    required this.child,
    this.height = 1000, // ارتفاع مبدئي يمكن تعديله
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(  // لجعل المحتوى قابلًا للتمرير
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(60.sp),
            topLeft: Radius.circular(60.sp),
          ),
          color: ColorsManager.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0.sp, top: 16.sp),
                child: Container(
                  width: 50.w,
                  height: 6.sp,
                  decoration: BoxDecoration(
                    color: ColorsManager.secondGreen,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            verticalSpace(12.h),
            // نستخدم Expanded مع ScrollView لكي نسمح بالتوسع التلقائي للمحتوى
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              child: child,
            ),
            verticalSpace(16.h), // المسافة بين المحتوى وأسفل الـ BottomSheet
          ],
        ),
      ),
    );
  }
}
