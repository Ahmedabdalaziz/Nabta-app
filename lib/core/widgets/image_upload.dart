import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/features/signup/ui/signup_screen.dart';

import '../helper/spacing.dart';
import '../helper/strings.dart';
import '../routing/routing.dart';
import '../theming/color.dart';
import '../theming/style_manager.dart';
import 'app_text_button.dart';
import 'indecator.dart';

class UploadingImageScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SignupScreen(
          customContent: Column(
            children: [
              verticalSpace(70.sp),
              Stack(
                children: [
                  Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorsManager.secondGreen,
                      width: 5.0.w,
                    ),
                  ),
                ),
                  ClipOval(
                    child: SvgPicture.asset(
                      placeHolderImage,
                      width: 190.w, // Adjust to fit within the border
                      height: 190.h,
                      fit: BoxFit.cover, // Fills the circle without distortion
                    ),
                  ),
                ]
              ),
              verticalSpace(60.sp),
              SizedBox(
                height: 56.h ,
                width: 408.w ,
                child: DarkCustomTextButton(
                  text: 'حفظ كلمة المرور',
                  textStyle: CairoTextStyles.extraBold
                      .copyWith(fontSize: 20.sp, color: ColorsManager.white),
                  onPressed: (){
                    context.pushNamed(Routing.uploadingImageScreen);
                  },
                ),
              ),
              verticalSpace(50.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60.h,
                    width: 379.w,
                    child: Text(
                      'يمكنك تخطي إضافة صورة شخصية ، وسيتم تلقائيًا تعيين صورة رمزية بدلاً منها',
                      textAlign: TextAlign.right,
                      style: CairoTextStyles.medium.copyWith(
                          fontSize: 16.sp, color: ColorsManager.mainGreen),
                    ),
                  ),
                  horizontalSpace(12.sp),
                  SvgPicture.asset(alertSvg),
                ],
              ),

              verticalSpace(30.sp),

              SizedBox(
                width: 80.w,
                height: 80.h,
                child: GestureDetector(
                  onTap: (){},
                  child: CircleProgressBar(
                    animationDuration: const Duration(seconds: 1),
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: ColorsManager.secondGreen,
                    value: 0.75,
                  ),
                ),
              ),

            ],
          ),
      ),
    );
  }
}