import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class GuideLinesCards extends StatelessWidget {
  final String label;
  final String icon_image;
  final String description; // Add a description parameter

  const GuideLinesCards({
    super.key,
    required this.label,
    required this.icon_image,
    required this.description, // Initialize the description
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 408.w,
      margin: EdgeInsets.symmetric(vertical: 8.h), // Add margin for spacing
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/SVGs/plants/Frame 162.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w), // Add padding inside the card
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text content on the left
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end, // Align text to the right
                mainAxisSize: MainAxisSize.min, // Column height adjusts to content
                children: [
                  // Label
                  Text(
                    label,
                    style: CairoTextStyles.bold.copyWith(
                      fontSize: 16.sp,
                      color: ColorsManager.secondGreen,
                    ),
                  ),
                  verticalSpace(8.h), // Add spacing between label and description
                  // Description
                  Text(
                    description,
                    style: CairoTextStyles.semiBold.copyWith(
                      fontSize: 16.sp,
                      color: ColorsManager.secondGreen,
                    ),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                    softWrap: true, // Allow text to wrap to the next line
                  ),
                ],
              ),
            ),
            horizontalSpace(10.w), // Add spacing between text and icon
            // Icon on the right
            SizedBox(
              height: 48.h,
              width: 48.w,
              child: Image.asset(icon_image),
            ),
          ],
        ),
      ),
    );
  }
}