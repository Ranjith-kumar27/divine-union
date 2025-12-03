import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

/// Typography tokens.
/// Lora is used for headings (as per Figma). Inter for body text.
/// Make sure fonts are added to pubspec.yaml & assets/fonts/.
class AppTextStyles {
  AppTextStyles._();

  // Responsive font size calculator
  static double _responsiveFontSize(
    BuildContext context, {
    required double heightFactor,
    double minSize = 10.0,
    double maxSize = 32.0,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    return (screenHeight * heightFactor).clamp(minSize, maxSize);
  }

  // Responsive heading style - using Lora
  static TextStyle heading(BuildContext context) {
    return TextStyle(
      fontFamily: 'Lora',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.03,
        minSize: 20.0,
        maxSize: 28.0,
      ),
      height: AppSizes.headingLineHeight / AppSizes.headingFontSize,
      fontWeight: FontWeight.w600,
      // Changed from w500 to w600 for emphasis
      letterSpacing: -0.01 * AppSizes.headingFontSize,
      color: AppColors.textPrimary,
    );
  }

  // Responsive body / regular text — Inter family
  static TextStyle body(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.018,
        minSize: 14.0, // Increased min size from 12 to 14
        maxSize: 16.0,
      ),
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    );
  }

  // Responsive button label style (Inter SemiBold)
  static TextStyle buttonLabel(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.02,
        minSize: 16.0, // Increased from 14
        maxSize: 18.0,
      ),
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
  }

  // Responsive small label (Medium weight for resend code)
  static TextStyle label(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.017,
        minSize: 14.0, // Increased from 10-14 to 14-16 for medium size
        maxSize: 16.0,
      ),
      fontWeight: FontWeight.w500, // Medium weight
      color: AppColors.textSecondary,
    );
  }

  // NEW: Specific style for resend code text with primary color
  static TextStyle resendCode(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.017,
        minSize: 14.0,
        maxSize: 16.0,
      ),
      fontWeight: FontWeight.w500, // Medium weight
      color: AppColors.primary,
    );
  }

  // Inter Bold for emphasis
  static TextStyle bold(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.018,
        minSize: 12.0,
        maxSize: 16.0,
      ),
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    );
  }

  // Lora Regular for secondary headings
  static TextStyle subheading(BuildContext context) {
    return TextStyle(
      fontFamily: 'Lora',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.024,
        minSize: 18.0,
        maxSize: 22.0,
      ),
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
    );
  }

  // OTP field text style
  static TextStyle otpField(BuildContext context) {
    return TextStyle(
      fontFamily: 'Lora',
      fontSize: 28.0,
      fontWeight: FontWeight.w600, // Changed to semi-bold for better visibility
      color: AppColors.textPrimary,
    );
  }
}
