import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CategorySelectionWidget extends StatefulWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategorySelectionWidget({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  State<CategorySelectionWidget> createState() =>
      _CategorySelectionWidgetState();
}

class _CategorySelectionWidgetState extends State<CategorySelectionWidget> {
  late String currentCategory;

  @override
  void initState() {
    super.initState();
    currentCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 150,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCategoryButton(["حشرات", "نباتات"], currentCategory),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(List<String> text, String selectedCategory) {
    return ToggleSwitch(
      fontSize: 22.sp,
      minWidth: 100.0.w,
      cornerRadius: 20.0.r,
      inactiveFgColor: Colors.white,
      initialLabelIndex: text.indexOf(selectedCategory),
      totalSwitches: 2,
      labels: text,
      activeBgColor: [ColorsManager.mainGreen],
      textDirectionRTL: true,
      activeFgColor: ColorsManager.white,
      inactiveBgColor: Colors.transparent,
      borderColor: [ColorsManager.white],
      customTextStyles: [
        CairoTextStyles.black,
        CairoTextStyles.black,
      ],
      onToggle: (index) {
        if (index != null) {
          setState(() {
            currentCategory = text[index];
          });
          widget.onCategorySelected(text[index]);
        }
      },
    );
  }
}
