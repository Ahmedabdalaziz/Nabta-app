import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spacing.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';

class CustomDateField extends StatefulWidget {
  final TextEditingController? controller;
  final Color textColor;
  final bool showError;

  const CustomDateField({
    Key? key,
    this.controller,
    required this.textColor,
    this.showError = false,
  }) : super(key: key);

  @override
  _CustomDateFieldState createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  DateTime _selectedDate = DateTime.now();

  void _selectDate(BuildContext context) {
    showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50.sp),
        ),
      ),
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(70.sp),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0.sp),
              ),
              Container(
                width: 50.w,
                height: 6.sp,
                decoration: BoxDecoration(
                  color: ColorsManager.secondGreen,
                  borderRadius: BorderRadius.circular(100.sp),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 26.0.h, horizontal: 32.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCustomButton("Day"),
                    _buildCustomButton("Month"),
                    _buildCustomButton("Year"),
                  ],
                ),
              ),
              Expanded(
                child: ScrollWheelDatePicker(
                  onSelectedItemChanged: (date) {
                    setState(() {
                      _selectedDate = date;
                      widget.controller?.text =
                          '${date.day}/${date.month}/${date.year}';
                    });
                  },
                  lastDate: DateTime.now(),
                  initialDate: DateTime(
                    _selectedDate.year,
                    _selectedDate.month,
                    _selectedDate.day,
                  ),
                  theme: FlatDatePickerTheme(
                    overlay: ScrollWheelDatePickerOverlay.holo,
                    itemTextStyle: CairoTextStyles.bold
                        .copyWith(color: ColorsManager.secondGreen),
                    overlayColor: ColorsManager.secondGreen,
                    overAndUnderCenterOpacity: 0.2,
                    itemExtent: 50.0,
                    wheelPickerHeight: 200.0,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: ElevatedButton(
                  onPressed: () {
                    widget.controller?.text =
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: ColorsManager.secondGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0.sp),
                      side: const BorderSide(
                          color: ColorsManager.secondGreen, width: 2.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  ),
                  child: Text("إضافة",
                      style: CairoTextStyles.bold.copyWith(
                          fontSize: 20.sp, color: ColorsManager.secondGreen)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCustomButton(String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: ColorsManager.secondGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.sp),
          side: const BorderSide(
            color: ColorsManager.secondGreen,
            width: 2.0,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      ),
      onPressed: () {},
      child: Text(
        label,
        style: CairoTextStyles.bold.copyWith(
          color: ColorsManager.secondGreen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          style: CairoTextStyles.bold.copyWith(
            color: ColorsManager.grey,
            fontSize: 18.0.sp,
          ),
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: "إدخل تاريخ الميلاد",
            hintStyle: CairoTextStyles.regular.copyWith(
              color: ColorsManager.grey,
              fontSize: 18.0.sp,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.sp),
              borderSide: BorderSide(width: 2.0.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.sp),
              borderSide: BorderSide(
                color: widget.showError
                    ? ColorsManager.red
                    : ColorsManager.secondGreen,
                width: 2.0.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.sp),
              borderSide: BorderSide(
                color: widget.showError
                    ? ColorsManager.red
                    : ColorsManager.mainGreen,
                width: 2.0.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
