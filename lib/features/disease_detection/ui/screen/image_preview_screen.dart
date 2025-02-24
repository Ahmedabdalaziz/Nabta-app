import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/helper/token.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/disease_detection/logic/disease_cubit.dart';
import 'package:graduation_project/features/disease_detection/ui/screen/background_camera.dart';
import 'package:lottie/lottie.dart';

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({super.key});

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  late Timer _textTimer;
  final ValueNotifier<String> _buttonTextNotifier = ValueNotifier("إرسال الصورة...");

  @override
  void initState() {
    super.initState();
    _textTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _buttonTextNotifier.value = _buttonTextNotifier.value == "إرسال الصورة..."
          ? "تحليل الحالة وتحديد التشخيص..."
          : "إرسال الصورة...";
    });
  }

  @override
  void dispose() {
    _textTimer.cancel();
    _buttonTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cachedImage = context.read<DiseaseCubit>().getCachedImage();

    return BackgroundCamera(
      customWidget: BlocConsumer<DiseaseCubit, DiseaseState>(
        listener: (context, state) {
          if (state is DiseaseFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: CairoTextStyles.medium.copyWith(
                    color: ColorsManager.red,
                  ),
                ),
                backgroundColor: ColorsManager.white,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DiseaseLoading) {
            return Center(
              child: Lottie.asset(
                "assets/lottie/plant_disease_loading.json",
                width: 100.w,
                height: 100.h,
              ),
            );
          } else if (state is DiseaseSuccess) {
            return Center(
              child: Text(
                "✅ تم الكشف بنجاح: ${state.response}",
                style: CairoTextStyles.bold.copyWith(
                  fontSize: 18.sp,
                  color: ColorsManager.mainGreen,
                ),
              ),
            );
          }

          if (cachedImage != null) {
            Uint8List imageBytes = base64Decode(cachedImage);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "جاري فحص النبتة",
                    style: CairoTextStyles.bold.copyWith(
                      fontSize: 30.sp,
                      color: ColorsManager.mainGreen,
                    ),
                  ),
                  verticalSpace(40.h),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorsManager.mainGreen,
                        width: 5.w,
                      ),
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26.r),
                      child: Image.memory(
                        imageBytes,
                        width: 400.w,
                        height: 400.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  verticalSpace(50.h),
                  ValueListenableBuilder<String>(
                    valueListenable: _buttonTextNotifier,
                    builder: (context, text, _) {
                      return Column(
                        children: [
                          verticalSpace(10.h),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: Text(
                              text,
                              key: ValueKey<String>(text),
                              style: CairoTextStyles.medium.copyWith(
                                fontSize: 18.sp,
                                color: ColorsManager.mainGreen,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                "❌ لم يتم العثور على صورة!",
                style: CairoTextStyles.medium.copyWith(
                  fontSize: 18.sp,
                  color: ColorsManager.red,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
