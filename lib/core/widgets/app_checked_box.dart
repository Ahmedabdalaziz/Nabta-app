import 'package:flutter/material.dart';

import '../theming/color.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;
  final Color? checkColor;
  final Color? activeColor;
  final BorderSide? borderSide;
  final double splashRadius;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.checkColor = Colors.white,
    this.activeColor = ColorsManager.mainGreen,
    this.borderSide,
    this.splashRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      splashRadius: splashRadius,
      side: borderSide,
      value: value,
      onChanged: onChanged,
      checkColor: checkColor,
      activeColor: activeColor,
    );
  }
}
