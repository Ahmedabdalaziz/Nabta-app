import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/functions.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:graduation_project/core/widgets/app_text_button.dart';
import 'package:graduation_project/features/report/logic/report_cubit.dart';

class UploadImageSection extends StatefulWidget {
  final List<String> uploadedImages;
  final Function(List<String>) onImagesUpdated;

  const UploadImageSection({
    super.key,
    required this.uploadedImages,
    required this.onImagesUpdated,
  });

  @override
  _UploadImageSectionState createState() => _UploadImageSectionState();
}

class _UploadImageSectionState extends State<UploadImageSection> {
  final ImageHandler _imageHandler = ImageHandler();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "رفع الصورة",
            style: CairoTextStyles.bold.copyWith(
              fontSize: 22.sp,
              color: ColorsManager.secondGreen,
            ),
          ),
          verticalSpace(8.h),
          Text(
            "صور الحيوان في إضاءة جيدة وزاوية تُظهر الإصابة بوضوح، مع صورة مقربة وأخرى للجسم كاملًا. الحد الأقصى 3 صور فقط.",
            style: CairoTextStyles.medium
                .copyWith(fontSize: 16.sp, color: ColorsManager.secondGreen),
            textAlign: TextAlign.end,
          ),
          verticalSpace(28.h),
          Center(
            child: SizedBox(
              width: 250.w,
              height: 56.h,
              child: DarkCustomTextButton(
                textStyle: CairoTextStyles.extraBold
                    .copyWith(color: ColorsManager.white, fontSize: 20.sp),
                text: "رفع صورة الحيوان",
                onPressed: widget.uploadedImages.length < 3 ? _pickImage : null,
                bottomColor: widget.uploadedImages.length < 3
                    ? ColorsManager.mainGreen
                    : ColorsManager.mainGreen.withOpacity(0.3),
              ),
            ),
          ),
          verticalSpace(12.h),
          ...widget.uploadedImages.map((image) => _imagePreview(image)),
          verticalSpace(16.h),
        ],
      ),
    );
  }

  void _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalSpace(10),
              Container(
                width: 50.w,
                height: 6.sp,
                decoration: BoxDecoration(
                  color: ColorsManager.secondGreen,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              verticalSpace(10),
              ListTile(
                contentPadding: EdgeInsets.zero,
                trailing: Icon(Icons.camera_alt_outlined,
                    color: ColorsManager.mainGreen),
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "التقاط صورة بالكاميرا",
                    style: CairoTextStyles.bold
                        .copyWith(color: ColorsManager.secondGreen),
                  ),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  String? base64Image =
                      await _imageHandler.pickImageFromCameraAsBase64();
                  _addImage(base64Image);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                trailing: Icon(Icons.image, color: ColorsManager.mainGreen),
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "اختيار من المعرض",
                    style: CairoTextStyles.bold
                        .copyWith(color: ColorsManager.secondGreen),
                  ),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  String? base64Image =
                      await _imageHandler.pickImageFromGalleryAsBase64();
                  _addImage(base64Image);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _addImage(String? base64Image) {
    if (base64Image != null && widget.uploadedImages.length < 3) {
      List<String> updatedImages = List.from(widget.uploadedImages)
        ..add(base64Image);
      widget.onImagesUpdated(updatedImages);
      context
          .read<ReportCubit>()
          .updateImages(updatedImages);
    }
  }

  void _removeImage(String base64Image) {
    List<String> updatedImages = List.from(widget.uploadedImages)
      ..remove(base64Image);
    widget.onImagesUpdated(updatedImages);
    context
        .read<ReportCubit>()
        .updateImages(updatedImages);
  }

  void _replaceImage(String oldImage) async {
    String? newBase64Image = await _imageHandler.pickImageFromGalleryAsBase64();
    if (newBase64Image != null) {
      List<String> updatedImages = List.from(widget.uploadedImages);
      int index = updatedImages.indexOf(oldImage);
      if (index != -1) {
        updatedImages[index] = newBase64Image;
        widget.onImagesUpdated(updatedImages);
        context
            .read<ReportCubit>()
            .updateImages(updatedImages);
      }
    }
  }

  Widget _imagePreview(String base64Image) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => _replaceImage(base64Image),
              child: Text("استبدال الصورة",
                  style: CairoTextStyles.bold
                      .copyWith(color: ColorsManager.secondGreen)),
            ),
            verticalSpace(20.h),
            GestureDetector(
              onTap: () => _removeImage(base64Image),
              child: Text("حذف الصورة",
                  style:
                      CairoTextStyles.bold.copyWith(color: ColorsManager.red)),
            ),
          ],
        ),
        horizontalSpace(8.w),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: SizedBox(
            width: 90.w,
            height: 90.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.memory(base64Decode(base64Image),
                  width: 90.w, height: 90.h, fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }
}
