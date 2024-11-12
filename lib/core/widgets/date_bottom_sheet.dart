import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';

class CustomDateField extends StatefulWidget {
  final TextEditingController? controller;
  final Color textColor;
  final bool showError;
  final ValueChanged<String>? onDateSelected;  // تعديل هنا

  const CustomDateField({
    Key? key,
    this.controller,
    required this.textColor,
    this.showError = false,
    this.onDateSelected,
  }) : super(key: key);

  @override
  _CustomDateFieldState createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  DateTime _selectedDate = DateTime.now();

  void _selectDate(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(70.sp)),
          ),
          height: 500.h,
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
                padding: EdgeInsets.symmetric(vertical: 26.0.h, horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLabelContainer("Day"),
                    _buildLabelContainer("Month"),
                    _buildLabelContainer("Year"),
                  ],
                ),
              ),
              Expanded(
                child: ScrollWheelDatePicker(
                  onSelectedItemChanged: (date) {
                    setState(() {
                      _selectedDate = date;
                      DateFormat dateFormat = DateFormat('dd/MM/yyyy');
                      widget.controller?.text = dateFormat.format(date);
                    });
                  },
                  lastDate: DateTime.now(),
                  initialDate: _selectedDate,
                  theme: FlatDatePickerTheme(
                    overlay: ScrollWheelDatePickerOverlay.holo,
                    itemTextStyle: CairoTextStyles.bold.copyWith(
                      color: ColorsManager.secondGreen,
                    ),
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
                    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
                    String formattedDate = dateFormat.format(_selectedDate);
                    widget.controller?.text = formattedDate;
                    widget.onDateSelected?.call(formattedDate);  // تعديل هنا
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: ColorsManager.secondGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: const BorderSide(
                          color: ColorsManager.secondGreen, width: 2.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  ),
                  child: Text(
                    "إضافة",
                    style: CairoTextStyles.bold.copyWith(
                      fontSize: 20.sp,
                      color: ColorsManager.secondGreen,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLabelContainer(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0.sp),
        border: Border.all(color: ColorsManager.secondGreen, width: 2.0.w),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.secondGreen,
          ),
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
