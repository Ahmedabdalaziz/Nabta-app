import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/features/disease_detection/logic/disease_cubit.dart';
import 'package:graduation_project/features/disease_detection/ui/screen/background_camera.dart';
import 'package:pro_kit_snackbar/snack_bar/snack_bar.dart';
import 'package:pro_kit_snackbar/snack_bar/snackbar_enum.dart';

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({super.key});

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  late Timer _textTimer;
  final ValueNotifier<String> _buttonTextNotifier =
  ValueNotifier("جاري إرسال الصورة...");
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _loadImageBytes();

    context.read<DiseaseCubit>().submitDiseaseData();

    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        context.pushNamedAndRemoveUntil(Routing.resultImageDetection);
      }
    });

    _textTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _buttonTextNotifier.value = _buttonTextNotifier.value == "جاري إرسال الصورة..."
          ? "جاري تحديد التشخيص..."
          : "جاري إرسال الصورة...";
    });
  }

  Future<void> _loadImageBytes() async {
    final cachedImageFile = context.read<DiseaseCubit>().getCachedImageFile();
    if (cachedImageFile != null && await cachedImageFile.exists()) {
      _imageBytes = await cachedImageFile.readAsBytes();
      setState(() {});
    } else {
      _imageBytes = null;
      setState(() {});
      print("Cached image file is null or does not exist.");
    }
  }

  @override
  void dispose() {
    _textTimer.cancel();
    _buttonTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundCamera(
      customWidget: BlocConsumer<DiseaseCubit, DiseaseState>(
        listener: (context, state) {
          if (state is DiseaseFailure) {
            showProKitSnackBar(
              context,
              title: "هنالك مشكلة ما",
              titleTextStyle:
              CairoTextStyles.bold.copyWith(color: ColorsManager.greenWhite),
              message: "يبدو ان هنالك مشكلة في الاتصال مع الخادم أو في معالجة الصورة.",
              snackBarType: ProKitSnackBarType.colored,
              notificationType: ProKitNotificationType.failure,
              color: ColorsManager.mainGreen,
              autoCloseDuration: const Duration(seconds: 5),
              messageTextStyle:
              CairoTextStyles.bold.copyWith(color: ColorsManager.greenWhite),
            );
          }
        },
        builder: (context, state) {
          if (_imageBytes != null) {
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
                        _imageBytes!,
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