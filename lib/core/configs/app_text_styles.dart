import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppFont { manrope, inter }

class AppTextStyles {
  // ===== Font Selector =====
  static TextStyle _getFont(AppFont font) {
    switch (font) {
      case AppFont.manrope:
        return GoogleFonts.manrope();
      case AppFont.inter:
        return GoogleFonts.inter();
    }
  }

  // ===== Base Style =====
  static TextStyle _textStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required AppFont font,
    Color? color,
  }) {
    return _getFont(
      font,
    ).copyWith(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  // ===== REGULAR =====
  static TextStyle regular({
    required double size,
    AppFont font = AppFont.manrope,
    Color? color,
  }) => _textStyle(
    fontSize: size,
    fontWeight: FontWeight.normal,
    font: font,
    color: color,
  );

  // ===== SEMIBOLD =====
  static TextStyle semibold({
    required double size,
    AppFont font = AppFont.manrope,
    Color? color,
  }) => _textStyle(
    fontSize: size,
    fontWeight: FontWeight.w500,
    font: font,
    color: color,
  );

  // ===== BOLD =====
  static TextStyle bold({
    required double size,
    AppFont font = AppFont.manrope,
    Color? color,
  }) => _textStyle(
    fontSize: size,
    fontWeight: FontWeight.bold,
    font: font,
    color: color,
  );
}
