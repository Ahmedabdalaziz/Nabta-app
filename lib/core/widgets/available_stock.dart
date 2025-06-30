import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class AvailableStock extends StatefulWidget {
  final String imgPath;
  final String label;
  final int boxH;
  final int boxW;
  final int topPositioned;
  final int leftPositioned;
  final int containerH; // New property for container height
  final int containerW; // New property for container width


  const AvailableStock({
    super.key,
    required this.imgPath,
    required this.label,
    this.boxH = 130,
    this.boxW = 110,
    required this.topPositioned,
    required this.leftPositioned,
    this.containerH = 140, // Default value for container height
    this.containerW = 140, // Default value for container width
  });

  @override
  State<AvailableStock> createState() => _AvailableStockState();
}

class _AvailableStockState extends State<AvailableStock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Use the new properties here
      height: widget.containerH.h,
      width: widget.containerW.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: ColorsManager.greenWhite,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 3,
            left: 0,
            child: Padding(
              padding: EdgeInsets.only(top: 4.h, left: 6.w),
              child: Text(widget.label,
                  style: CairoTextStyles.bold.copyWith(
                      fontSize: 20.sp, color: ColorsManager.secondGreen)),
            ),
          ),
          Positioned(
            left: widget.leftPositioned.w,
            top: widget.topPositioned.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.sp),
              child: SizedBox(
                  height: widget.boxH.h,
                  width: widget.boxW.w,
                  child: Image.network(widget.imgPath)),
            ),
          ),
        ],
      ),
    );
  }
}