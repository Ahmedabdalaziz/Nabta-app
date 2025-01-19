import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:graduation_project/features/signup/logic/signup_cubit.dart';
import 'package:graduation_project/features/signup/ui/widget/signup_screen.dart';

class UploadingImageScreen extends StatefulWidget {
  @override
  _UploadingImageScreenState createState() => _UploadingImageScreenState();
}

class _UploadingImageScreenState extends State<UploadingImageScreen> {
  bool imageSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          log("Signup successful: ${state.message}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          context.pushNamed(Routing.otpScreen);
        } else if (state is SignupError) {
          log("Signup error: ${state.message}");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("There is a problem")),
          );
        }
      },
      builder: (context, state) {
        final signupCubit = BlocProvider.of<SignupCubit>(context);

        return Stack(
          children: [
            SignupScreen(
              customContent: Column(
                children: [
                  verticalSpace(38.sp),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        final imageHandler = ImageHandler();
                        String? imageBase64 =
                        await imageHandler.pickImageAsBase64();

                        if (imageBase64 != null) {
                          signupCubit.updateProfileImage(imageBase64);
                          setState(() {
                            imageSelected = true;
                          });
                        } else {
                          log("No image was selected.");
                        }
                      },
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                            begin: 190.0, end: imageSelected ? 250.0 : 190.0),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, size, child) {
                          return Container(
                            width: size.w,
                            height: size.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: imageSelected
                                    ? ColorsManager.mainGreen
                                    : ColorsManager.moreWhite,
                                width: 5.0.w,
                              ),
                            ),
                            child: ClipOval(
                              child: signupCubit.signupData.profileImage != null
                                  ? Image.memory(
                                base64Decode(
                                    signupCubit.signupData.profileImage!),
                                fit: BoxFit.cover,
                              )
                                  : SvgPicture.asset(
                                placeHolderImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  verticalSpace(80.sp),
                  SizedBox(
                    height: 56.h,
                    width: 408.w,
                    child: DarkCustomTextButton(
                      bottomColor: imageSelected
                          ? ColorsManager.mainGreen
                          : ColorsManager.secondGreen,
                      text: imageSelected ? 'تم حفظ الصورة' : 'إضافة صورة',
                      textStyle: CairoTextStyles.extraBold.copyWith(
                        fontSize: 20.sp,
                        color: imageSelected
                            ? ColorsManager.mainGreen
                            : ColorsManager.moreWhite,
                      ),
                      onPressed: () async {
                        if (!imageSelected) {
                          final imageHandler = ImageHandler();
                          String? imageBase64 =
                          await imageHandler.pickImageAsBase64();

                          if (imageBase64 != null) {
                            signupCubit.updateProfileImage(imageBase64);
                            setState(() {
                              imageSelected = true;
                            });
                          } else {
                            log("No image was selected.");
                          }
                        }
                      },
                    ),
                  ),
                  verticalSpace(32.sp),
                  if (!imageSelected) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/SVGs/icons/skip_lable.svg",
                          width: 400.w,
                          height: 60.h,
                        ),
                        horizontalSpace(12.sp),
                        SvgPicture.asset(alertSvg),
                      ],
                    ),
                  ],
                  verticalSpace(38.sp),
                  SizedBox(
                    width: 80.w,
                    height: 80.h,
                    child: GestureDetector(
                      onTap: () {
                        log("Submitting signup data");
                        signupCubit.submitSignup();
                      },
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
            if (state is SignupLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.mainGreen,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}