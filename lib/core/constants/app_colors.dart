import 'package:flutter/material.dart';

/// App-wide color tokens — use these instead of raw hex throughout the app.
class AppColors {
  AppColors._();

  // Primary purple exactly from your Figma screenshot
  static const Color primary = Color(0xFF6A6AF0); // #6A6AF0

  // Heading / primary text color
  static const Color textPrimary = Color(0xFF101026); // #101026

  static const Color disabled = Color(0xFFCDCDFA); // #CDCDFA

  // Secondary text (labels, hints)
  static const Color textSecondary = Color(0xFF8A8A8F);

  // Backgrounds
  static const Color scaffoldBackground = Color(0xFFFFFFFF);
  static const Color fieldBackground = Color(0xFFFFFFFF);

  // greys
  static const Color border = Color(0xFFE0E0E6);

  // Success / other
  static const Color success = Color(0xFF2ECC71);

  static const Color surface = Color(0xFFF9FAFB);
  static const Color error = Color(0xFFEF4444);
}