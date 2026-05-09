import 'package:flutter/material.dart';
class AppColors {
  AppColors._();
  static const Color primary = Color(0xFF004AC6);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF2563EB);
  static const Color onPrimaryContainer = Color(0xFFEEEFFF);
  static const Color inversePrimary = Color(0xFFB4C5FF);
  static const Color secondary = Color(0xFF505F76);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFD0E1FB);
  static const Color onSecondaryContainer = Color(0xFF54647A);
  static const Color tertiary = Color(0xFF4D556B);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF656D84);
  static const Color onTertiaryContainer = Color(0xFFEEF0FF);
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);
  static const Color surface = Color(0xFFFAF8FF);
  static const Color surfaceDim = Color(0xFFD9D9E5);
  static const Color surfaceBright = Color(0xFFFAF8FF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF3F3FE);
  static const Color surfaceContainer = Color(0xFFEDEDF9);
  static const Color surfaceContainerHigh = Color(0xFFE7E7F3);
  static const Color surfaceContainerHighest = Color(0xFFE1E2ED);
  static const Color surfaceVariant = Color(0xFFE1E2ED);
  static const Color onSurface = Color(0xFF191B23);
  static const Color onSurfaceVariant = Color(0xFF434655);
  static const Color surfaceTint = Color(0xFF0053DB);
  static const Color inverseSurface = Color(0xFF2E3039);
  static const Color inverseOnSurface = Color(0xFFF0F0FB);
  static const Color outline = Color(0xFF737686);
  static const Color outlineVariant = Color(0xFFC3C6D7);
  static const Color background = Color(0xFFFAF8FF);
  static const Color onBackground = Color(0xFF191B23);
  static const Color primaryFixed = Color(0xFFDBE1FF);
  static const Color primaryFixedDim = Color(0xFFB4C5FF);
  static const Color onPrimaryFixed = Color(0xFF00174B);
  static const Color onPrimaryFixedVariant = Color(0xFF003EA8);
  static const Color secondaryFixed = Color(0xFFD3E4FE);
  static const Color secondaryFixedDim = Color(0xFFB7C8E1);
  static const Color onSecondaryFixed = Color(0xFF0B1C30);
  static const Color onSecondaryFixedVariant = Color(0xFF38485D);
  static const Color tertiaryFixed = Color(0xFFDAE2FD);
  static const Color tertiaryFixedDim = Color(0xFFBEC6E0);
  static const Color onTertiaryFixed = Color(0xFF131B2E);
  static const Color onTertiaryFixedVariant = Color(0xFF3F465C);
  static const Color success = Color(0xFF16A34A);
  static const Color successContainer = Color(0xFFDCFCE7);
  static const Color onSuccessContainer = Color(0xFF14532D);
  static ColorScheme get lightColorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        surface: surface,
        onSurface: onSurface,
        surfaceContainerHighest: surfaceContainerHighest,
        surfaceContainerHigh: surfaceContainerHigh,
        surfaceContainer: surfaceContainer,
        surfaceContainerLow: surfaceContainerLow,
        surfaceContainerLowest: surfaceContainerLowest,
        surfaceDim: surfaceDim,
        surfaceBright: surfaceBright,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        inverseSurface: inverseSurface,
        onInverseSurface: inverseOnSurface,
        inversePrimary: inversePrimary,
        surfaceTint: surfaceTint,
      );
}
