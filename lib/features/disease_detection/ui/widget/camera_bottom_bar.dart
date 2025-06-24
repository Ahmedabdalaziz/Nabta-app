import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/features/disease_detection/ui/widget/camera_helper.dart';
import 'package:image_picker/image_picker.dart';

class CameraBottomBar extends StatelessWidget {
  final Function(String?) onCapture; // <--- هذا سيصبح مسار الملف
  final Function(String?) onPickImage; // <--- وهذا أيضاً

  final CameraHelper cameraHelper;

  const CameraBottomBar({
    super.key,
    required this.onCapture,
    required this.onPickImage,
    required this.cameraHelper,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.photo_library,
                    color: ColorsManager.white, size: 30.sp),
                onPressed: () async {
                  final imagePath =
                      await _pickImageFromGallery(); // <--- سيتم إرجاع المسار
                  onPickImage(imagePath); // تمرير مسار الصورة المختارة
                },
              ),
              GestureDetector(
                onTap: () async {
                  final imagePath =
                      await _captureImage(); // <--- سيتم إرجاع المسار
                  onCapture(imagePath); // تمرير مسار الصورة الملتقطة
                },
                child: SvgPicture.asset("assets/SVGs/plants/camera_button.svg"),
              ),
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: ColorsManager.mainGreen.withOpacity(0.3),
                ),
                child: Icon(Icons.info_outline,
                    color: ColorsManager.white, size: 35.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة التقاط الصورة من الكاميرا
  Future<String?> _captureImage() async {
    try {
      final XFile? imageFile = await cameraHelper.controller.takePicture();
      if (imageFile == null) {
        if (kDebugMode) {
          print("No image captured.");
        }
        return null;
      }
      return imageFile.path; // <--- إرجاع مسار الملف مباشرة
    } catch (e) {
      if (kDebugMode) {
        print("Error capturing image: $e");
      }
      return null;
    }
  }

  // دالة اختيار صورة من المعرض
  Future<String?> _pickImageFromGallery() async {
    try {
      final XFile? imageFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageFile == null) {
        if (kDebugMode) {
          print("No image selected.");
        }
        return null;
      }
      return imageFile.path; // <--- إرجاع مسار الملف مباشرة
    } catch (e) {
      if (kDebugMode) {
        print("Error picking image: $e");
      }
      return null;
    }
  }
}
