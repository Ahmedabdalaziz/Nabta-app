import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/theming/color.dart';

class CameraTopBar extends StatelessWidget {
  final bool isFlashOn;
  final VoidCallback onFlashPressed;

  const CameraTopBar({
    super.key,
    required this.isFlashOn,
    required this.onFlashPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 15,
      right: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: _buildIcon(Icons.close),
          ),
          GestureDetector(
            onTap: onFlashPressed,
            child: _buildIcon(
                isFlashOn ? Icons.flash_off : Icons.flash_on_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.mainGreen.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(icon, color: ColorsManager.white, size: 36.sp),
    );
  }
}

