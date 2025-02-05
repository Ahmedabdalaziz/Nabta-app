import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/theming/color.dart';

class CameraBottomBar extends StatefulWidget {
  final VoidCallback onCapture;
  final VoidCallback onPickImage;

  const CameraBottomBar(
      {super.key, required this.onCapture, required this.onPickImage});

  @override
  State<CameraBottomBar> createState() => _CameraBottomBarState();
}

class _CameraBottomBarState extends State<CameraBottomBar> {
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
                onPressed: widget.onPickImage,
              ),
              GestureDetector(
                  onTap: () {
                    widget.onCapture;
                  },
                  child:
                      SvgPicture.asset("assets/SVGs/plants/camera_button.svg")),
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
}
