import 'package:flutter/material.dart';

/// App-wide color tokens — use these instead of raw hex throughout the app.
class AppColors {
  AppColors._();

  // Primary purple exactly from your Figma screenshot
  static const Color primary = Color(0xFF6A6AF0); // #6A6AF0

  // Heading / primary text color
  static const Color textPrimary = Color(0xFF101026); // #101026

  static const Color disabled = Color(0xFFCDCDFA); // #CDCDFA

  static const Color liteDisabled = Color(0xFFF2F2FD);

  // Secondary text (labels, hints)
  static const Color textSecondary = Color(0xFF8A8A8F);

  static const Color textTertiary = Color(0xFF3B3B4D);

  // Backgrounds
  static const Color scaffoldBackground = Color(0xFFFFFFFF);
  static const Color fieldBackground = Color(0xFFFFFFFF);

  // Navigation
  static const Color navBarBackground = Color(0xFFFFFFFF);
  static const Color navBarShadow = Color(0x1A000000);
  static const Color navBarInactive = Color(0xFF8A8A8F);

  // Profile card
  static const Color profileGradientStart = Color(0x00000000);
  static const Color profileGradientEnd = Color(0xCC000000);
  static const Color profileTagBackground = Color(0x33FFFFFF);
  static const Color premiumBadgeBackground = Color(0x1A6A6AF0);

  // Action buttons
  static const Color likeButtonShadow = Color(0x4D6A6AF0);
  static const Color dislikeButtonShadow = Color(0x33000000);

  // greys
  static const Color border = Color(0xFFE0E0E6);
  static const Color divider = Color(0xFFF0F0F0);

  // Success / other
  static const Color success = Color(0xFF2ECC71);

  static const Color surface = Color(0xFFF9FAFB);
  static const Color error = Color(0xFFEF4444);

  // Status bar
  static const Color statusBar = Color(0xFFFFFFFF);
}