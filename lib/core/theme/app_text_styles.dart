import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AppTextStyles {
  AppTextStyles._();
  static TextStyle get _baseTextStyle => GoogleFonts.inter();
  static TextStyle get displayLg => _baseTextStyle.copyWith(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        height: 38 / 30, // lineHeight / fontSize
        letterSpacing: -0.02 * 30, // -0.02em
      );
  static TextStyle get headlineMd => _baseTextStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 32 / 24,
        letterSpacing: -0.01 * 24,
      );
  static TextStyle get titleLg => _baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 28 / 20,
      );
  static TextStyle get titleMd => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 24 / 16,
      );
  static TextStyle get bodyLg => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      );
  static TextStyle get bodyMd => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
      );
  static TextStyle get labelLg => _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 16 / 12,
        letterSpacing: 0.05 * 12, // 0.05em
      );
  static TextStyle get labelMd => _baseTextStyle.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 16 / 11,
      );
  static TextTheme get textTheme => TextTheme(
        displayLarge: displayLg,
        headlineMedium: headlineMd,
        titleLarge: titleLg,
        titleMedium: titleMd,
        bodyLarge: bodyLg,
        bodyMedium: bodyMd,
        labelLarge: labelLg,
        labelMedium: labelMd,
      );
}
