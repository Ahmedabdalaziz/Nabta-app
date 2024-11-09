import 'package:flutter/material.dart';

class CairoTextStyles {
  static const String _fontFamily = 'Cairo';

  static TextStyle get extraBold => const TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w800,
  );

  static TextStyle get bold => const TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get semiBold => const TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get medium => const TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get regular => const TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get light => const TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w300,

  );

  static TextStyle get black => const TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w900,
  );

  static TextStyle get thin => const TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w100,
  );
}
