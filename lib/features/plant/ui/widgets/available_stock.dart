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

  const AvailableStock({
    super.key,
    required this.imgPath,
    required this.label,
    this.boxH = 100,
    this.boxW = 100,
    required this.topPositioned,
    required this.leftPositioned,
  });

  @override
  State<AvailableStock> createState() => _AvailableStockState();
}

class _AvailableStockState extends State<AvailableStock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 120.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: ColorsManager.greenWhite,
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.h, left: 12.w),
            child: Text(widget.label,
                style: CairoTextStyles.bold.copyWith(
                    fontSize: 20.sp, color: ColorsManager.secondGreen)),
          ),
          Positioned(
            left: widget.leftPositioned.w, //25
            top: widget.topPositioned.h, //20
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.sp),
              child: SizedBox(
                  height: widget.boxH.h, width: widget.boxW.w, child: Image.network(widget.imgPath)),
            ),
          ),
        ],
      ),
    );
  }
}
