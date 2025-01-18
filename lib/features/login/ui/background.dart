import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';

class Background extends StatelessWidget {
  final Widget customContent;
  final bool showCloseButton;

  const Background(
      {super.key, required this.customContent, this.showCloseButton = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainGreen,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Transform.translate(
                    offset: Offset(0, 30.h),
                    child: SvgPicture.asset(
                      loginSVG,
                      height: 250.35.h,
                      width: 180.55.w,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 707.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.sp),
                      topLeft: Radius.circular(50.sp),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0.sp,
                        bottom: 0.sp,
                        child: SvgPicture.asset(
                          width: 300.w,
                          height: 400.h,
                          "assets/SVGs/login_screen/Plant Background.svg",
                        ),
                      ),
                      Column(
                        children: [customContent, verticalSpace(10.h)],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (showCloseButton) // إذا كانت showCloseButton = true، سيظهر الزر
              Positioned(
                top: 45.h,
                left: 30.w,
                child: GestureDetector(
                  onTap: () {
                    context.pushNamedAndRemoveUntil(Routing.loginScreen);
                  },
                  child: CustomPaint(
                    size: Size(50.w, 50.h),
                    painter: TransparentCircleWithX(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TransparentCircleWithX extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final Paint xPaint = Paint()
      ..color = ColorsManager.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, circlePaint);

    final double padding = 14.0;
    canvas.drawLine(
      Offset(padding, padding),
      Offset(size.width - padding, size.height - padding),
      xPaint,
    );
    canvas.drawLine(
      Offset(size.width - padding, padding),
      Offset(padding, size.height - padding),
      xPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
