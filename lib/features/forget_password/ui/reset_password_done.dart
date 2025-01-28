import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:graduation_project/features/login/ui/background.dart';

class ResetPassDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
      customContent: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verticalSpace(80.h),
              Container(
                width: 50.w,
                height: 6.sp,
                decoration: BoxDecoration(
                  color: ColorsManager.secondGreen,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          ),
          Text(
            'تمت اعادة تعيين كلمة المرور',
            style: CairoTextStyles.extraBold
                .copyWith(fontSize: 30.sp, color: ColorsManager.secondGreen),
          ),
          verticalSpace(64.h),
          SizedBox(
            width: 408.w,
            height: 90.h,
            child: SvgPicture.asset('assets/SVGs/password/awoda.svg'),
          ),
          verticalSpace(96.h),
          Stack(
            children: [
              SizedBox(
                width: 150.w,
                height: 150.h,
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundColor: ColorsManager.mainGreen,
                  child: CircleAvatar(
                    radius: 73.r,
                    backgroundColor: ColorsManager.moreWhite,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: SvgPicture.asset('assets/SVGs/password/Frame 10.svg'),
                ),
              ),
            ],
          ),
          verticalSpace(87.h),
          SizedBox(
            width: 408.w,
            height: 56.h,
            child: DarkCustomTextButton(
                text: 'العودة لتسجيل الدخول',
                onPressed: () {},
                textStyle: CairoTextStyles.extraBold
                    .copyWith(fontSize: 20.sp, color: ColorsManager.white)),
          ),
        ],
      ),
    );
  }
}
