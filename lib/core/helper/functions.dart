import 'package:flutter/material.dart';

TextAlign getTextAlign(String text) {
  final firstChar = text.isNotEmpty ? text.codeUnitAt(0) : 0;
  if (firstChar >= 0x600 && firstChar <= 0x6FF) {
    // Arabic range
    return TextAlign.right;
  } else {
    return TextAlign.left;
  }
}

TextDirection getTextDirection(String text) {
  final firstChar = text.isNotEmpty ? text.codeUnitAt(0) : 0;
  if (firstChar >= 0x600 && firstChar <= 0x6FF) {
    return TextDirection.rtl;
  } else {
    return TextDirection.ltr;
  }
}
