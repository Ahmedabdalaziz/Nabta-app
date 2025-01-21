import 'package:flutter/material.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';

class OTPInput extends StatefulWidget {
  final int length;
  final Function(String) onCompleted;
  final double boxWidth;
  final double boxHeight;
  final double spacing;
  final Color textColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color fillColor;
  final Color cursorColor;
  final double borderRadius;
  final double borderWidth;
  final TextStyle textStyle;
  final EdgeInsetsGeometry contentPadding;

  const OTPInput({
    super.key,
    required this.length,
    required this.onCompleted,
    this.boxWidth = 50,
    this.boxHeight = 50,
    this.spacing = 5,
    this.textColor = ColorsManager.secondGreen,
    this.borderColor = ColorsManager.secondGreen,
    this.focusedBorderColor = ColorsManager.secondGreen,
    this.fillColor = ColorsManager.moreWhite,
    this.cursorColor = ColorsManager.mainGreen,
    this.borderRadius = 10,
    this.borderWidth = 1,
    this.textStyle = const TextStyle(fontSize: 20),
    this.contentPadding = const EdgeInsets.all(8),
  });

  @override
  _OTPInputState createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  late List<String> _otp;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    _controllers = List.generate(widget.length, (index) => TextEditingController());
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
    _otp = List.filled(widget.length, '');
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && !RegExp(r'^\d+$').hasMatch(value)) {
      _controllers[index].clear();
      return;
    }

    setState(() {
      _otp[index] = value;
    });

    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index].unfocus();
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index].unfocus();
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }

    if (_otp.every((digit) => digit.isNotEmpty)) {
      widget.onCompleted(_otp.join());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Container(
          width: widget.boxWidth,
          height: widget.boxHeight,
          margin: EdgeInsets.symmetric(horizontal: widget.spacing),
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: CairoTextStyles.bold.copyWith(color: widget.textColor, fontSize: 20),
            cursorColor: widget.cursorColor,
            autofocus: index == 0,
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: widget.fillColor,
              contentPadding: widget.contentPadding,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: _otp[index].isEmpty ? widget.borderColor : widget.focusedBorderColor,
                  width: widget.borderWidth,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: _otp[index].isEmpty ? widget.borderColor : widget.focusedBorderColor,
                  width: widget.borderWidth,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: widget.focusedBorderColor,
                  width: widget.borderWidth,
                ),
              ),
            ),
            onChanged: (value) => _onChanged(index, value),
          ),
        );
      }),
    );
  }
}