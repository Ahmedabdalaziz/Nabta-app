import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/functions.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class DarkCustomTextField extends StatefulWidget {
  final Color textColor;
  final String? labelText;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? icon;
  final double borderCircular;
  final bool showError;
  final String? errorMessage;
  final TextAlign textAlign;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final FocusNode? focusNode; // إضافة FocusNode

  const DarkCustomTextField({
    Key? key,
    required this.textColor,
    this.labelText,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.icon,
    this.borderCircular = 10.0,
    this.showError = false,
    this.errorMessage,
    this.textAlign = TextAlign.right,
    this.onChanged,
    this.fillColor = Colors.white,
    this.focusNode, // FocusNode كمعامل اختياري
  }) : super(key: key);

  @override
  _DarkCustomTextFieldState createState() => _DarkCustomTextFieldState();
}

class _DarkCustomTextFieldState extends State<DarkCustomTextField> {
  bool _isEmpty = true;
  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      obscuringCharacter: '•',
      controller: widget.controller,
      obscureText: widget.isPassword ? _isObscured : false,
      keyboardType: widget.keyboardType ??
          (widget.isPassword
              ? TextInputType.visiblePassword
              : TextInputType.emailAddress),
      style: CairoTextStyles.bold.copyWith(
        color: ColorsManager.grey,
        fontSize: 18.0.sp,
      ),
      textAlign: _isEmpty
          ? getTextAlign(widget.labelText ?? '')
          : getTextAlign(widget.controller?.text ?? ''),
      decoration: InputDecoration(
        hintTextDirection: getTextDirection(widget.labelText ?? ''),
        filled: true,
        fillColor: widget.fillColor,
        hintText: widget.labelText,
        hintStyle: CairoTextStyles.regular.copyWith(
          color: ColorsManager.grey,
          fontSize: 16.0.sp,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderCircular),
          borderSide: BorderSide(width: 2.0.w),
        ),
        prefixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility_off : Icons.visibility,
            color: ColorsManager.secondGreen,
          ),
          onPressed: _toggleObscureText,
        )
            : null,
        suffixIcon: widget.icon,
        errorText: widget.showError ? widget.errorMessage : null,
        errorStyle: const TextStyle(color: ColorsManager.red),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderCircular),
          borderSide: BorderSide(
            color:
            widget.showError ? ColorsManager.red : ColorsManager.mainGreen,
            width: 2.0.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderCircular),
          borderSide: BorderSide(
            color: widget.showError
                ? ColorsManager.red
                : ColorsManager.secondGreen,
            width: 2.0.w,
          ),
        ),
      ),
      validator: widget.validator,
      onChanged: (value) {
        setState(() {
          _isEmpty = value.isEmpty;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      onTap: () {
        setState(() {
          _isEmpty = false;
        });
      },
    );
  }
}