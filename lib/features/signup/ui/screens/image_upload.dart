import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/functions.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:graduation_project/core/widgets/indecator.dart';
import 'package:graduation_project/features/signup/ui/widget/signup_screen.dart';

class UploadingImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupScreen(
        customContent: Column(
          children: [
            verticalSpace(70.sp),
            Center(
              child: GestureDetector(
                onTap: () async {
                  final imageHandler = ImageHandler();

                  String? imageBase64 = await imageHandler.pickImageAsBase64();

                  if (imageBase64 != null) {
                    print("Image Base64: $imageBase64");
                  } else {
                    print("No image was selected.");
                  }
                },
                child: SvgPicture.asset(
                  placeHolderImage,
                  width: 190.w, // Adjust to fit within the border
                  height: 190.h,
                  fit: BoxFit.cover, // Fills the circle without distortion
                ),
              ),
            ),
            verticalSpace(60.sp),
            SizedBox(
              height: 56.h,
              width: 408.w,
              child: DarkCustomTextButton(
                text: 'إضافة صورة',
                textStyle: CairoTextStyles.extraBold
                    .copyWith(fontSize: 20.sp, color: ColorsManager.white),
                onPressed: () {
                  context.pushNamed(Routing.uploadingImageScreen);
                },
              ),
            ),
            verticalSpace(50.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/SVGs/icons/skip_lable.svg",
                        width: 400.w,
                        height: 60.h,
                      )
                    ],
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
                onTap: () {},
                child: CircleProgressBar(
                  animationDuration: const Duration(seconds: 1),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: ColorsManager.secondGreen,
                  value: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
