import 'package:flutter/material.dart';
class AppSpacing {
  AppSpacing._();
  static const double unit = 8;
  static const double xs = 4;    // Jarak sangat kecil (icon ke label)
  static const double sm = 8;    // Jarak kecil (antar elemen related)
  static const double md = 16;   // Jarak medium (padding card, antar field)
  static const double lg = 24;   // Jarak besar (antar section)
  static const double xl = 32;   // Jarak sangat besar (section major)
  static const double marginMobile = 16;   // Margin kiri-kanan layar
  static const double gutterMobile = 12;   // Gap antar kolom (grid)
  static const double appBarHeight = 56;   // Tinggi AppBar
  static const double bottomNavHeight = 80; // Tinggi Bottom Navigation
  static const double buttonHeight = 48;    // Tinggi tombol standar
  static const double buttonHeightLg = 56;  // Tinggi tombol besar (Clock In)
  static const double inputHeight = 48;     // Tinggi input field
  static const double iconContainerSize = 40; // Ukuran container icon
  static const double avatarSize = 32;      // Ukuran avatar di AppBar
  static const double radiusSm = 4;    // 0.25rem
  static const double radius = 8;      // 0.5rem — default
  static const double radiusMd = 12;   // 0.75rem — cards, buttons
  static const double radiusLg = 16;   // 1rem — large containers
  static const double radiusXl = 24;   // 1.5rem — bottom sheet top
  static const double radiusFull = 9999; // Pill shape — chips, status tags
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: marginMobile,
  );
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(
    vertical: lg,
    horizontal: marginMobile,
  );
}
