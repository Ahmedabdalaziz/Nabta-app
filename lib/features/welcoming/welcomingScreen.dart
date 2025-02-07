import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:graduation_project/features/login/ui/background.dart';

class Welcom extends StatelessWidget {
  const Welcom({super.key});

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
              )
            ],
          ),
          Text(
            '! أهلا بك في نبتة ',
            style: CairoTextStyles.extraBold
                .copyWith(fontSize: 30, color: ColorsManager.secondGreen),
          ),
          verticalSpace(30.h),
          SizedBox(
            width: 408.w,
            height: 148.h,
            child: Column(
              children: [
                Text(
                    textAlign: TextAlign.center,
                    "تم إنشاء حسابك بنجاح . استعد لاكتشاف أدوات",
                    style: CairoTextStyles.bold.copyWith(
                        fontSize: 20.sp, color: ColorsManager.secondGreen)),
                verticalSpace(10.h),
                Text(
                    textAlign: TextAlign.center,
                    "مبتكرة ومعلومات موثوقة لمساعدتك في",
                    style: CairoTextStyles.bold.copyWith(
                        fontSize: 20.sp, color: ColorsManager.secondGreen)),
                verticalSpace(10.h),
                Text(
                    textAlign: TextAlign.center,
                    "رعاية مزروعاتك وتحقيق إنتاج أفضل. نحن هنا ",
                    style: CairoTextStyles.bold.copyWith(
                        fontSize: 20.sp, color: ColorsManager.secondGreen)),
                verticalSpace(10.h),
                Text(
                    textAlign: TextAlign.center,
                    " ! لدعمك في كل خطوة",
                    style: CairoTextStyles.bold.copyWith(
                        fontSize: 20.sp, color: ColorsManager.secondGreen)),
              ],
            ),
          ),
          verticalSpace(20.h),
          SizedBox(
            width: 341.w,
            height: 276.h,
            child: SvgPicture.asset(
              'assets/SVGs/welcome/Group 72.svg',
              fit: BoxFit.fill,
            ),
          ),
          verticalSpace(30.h),
          SizedBox(
            width: 408.w,
            child: DarkCustomTextButton(
                text: 'ابدأ الزراعة',
                onPressed: () {
                  context.pushNamedAndRemoveUntil(Routing.homeScreen);
                },
                textStyle: CairoTextStyles.extraBold
                    .copyWith(fontSize: 20.sp, color: ColorsManager.white)),
          )
        ],
      ),
    );
  }
}
