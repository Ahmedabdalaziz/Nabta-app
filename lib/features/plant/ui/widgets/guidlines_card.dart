import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class GuideLinesCards extends StatelessWidget {
  const GuideLinesCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 408.w,
      height: 100.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/SVGs/plants/Frame 162.png',
            fit: BoxFit.fill,
          ),
          Positioned(
            right: 10.w,
            top: 25.h,
            child: SizedBox(
                height: 48.h,
                width: 48.w,
                child: Image.asset('assets/SVGs/plants/Frame 163.png')),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.h, left: 150.w),
                    child: Text(
                      'موسم الزراعة',
                      style: CairoTextStyles.bold.copyWith(
                          fontSize: 16.sp, color: ColorsManager.secondGreen),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 70.w),
                    child: SizedBox(
                      width: 322.w,
                      height: 48.h,
                      child: Text(
                        'تربة خصبة جيدة التصريف، ويفضل أن تكون طينية أو طينية مختلطة بالرمل.',
                        style: CairoTextStyles.semiBold.copyWith(
                            fontSize: 16.sp, color: ColorsManager.secondGreen),
                        textAlign: TextAlign.justify,
                        //softWrap: true,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
