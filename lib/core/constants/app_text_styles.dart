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
        minSize: 14.0,
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
        minSize: 16.0,
        maxSize: 18.0,
      ),
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
  }

  // Responsive small label (Medium weight)
  static TextStyle label(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.017,
        minSize: 14.0,
        maxSize: 16.0,
      ),
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    );
  }

  // Style for resend code text with primary color
  static TextStyle resendCode(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.017,
        minSize: 14.0,
        maxSize: 16.0,
      ),
      fontWeight: FontWeight.w500,
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
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    );
  }

  // Profile name text style
  static TextStyle profileName(BuildContext context) {
    return TextStyle(
      fontFamily: 'Lora',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.025,
        minSize: 20.0,
        maxSize: 24.0,
      ),
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );
  }

  // Profile tag text style
  static TextStyle profileTag(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.015,
        minSize: 10.0,
        maxSize: 12.0,
      ),
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
  }

  // Match percentage text style
  static TextStyle matchPercentage(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.022,
        minSize: 18.0,
        maxSize: 20.0,
      ),
      fontWeight: FontWeight.w700,
      color: AppColors.primary,
    );
  }

  // Premium badge text style
  static TextStyle premiumBadge(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.017,
        minSize: 10.0,
        maxSize: 12.0,
      ),
      fontWeight: FontWeight.w700,
      color: AppColors.primary,
    );
  }

  // Section title text style
  static TextStyle sectionTitle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.022,
        minSize: 16.0,
        maxSize: 18.0,
      ),
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    );
  }

  // See all button text style
  static TextStyle seeAll(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.017,
        minSize: 12.0,
        maxSize: 14.0,
      ),
      fontWeight: FontWeight.w500,
      color: AppColors.primary,
    );
  }

  // Suggested profile name style
  static TextStyle suggestedProfileName(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.019,
        minSize: 14.0,
        maxSize: 16.0,
      ),
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    );
  }

  // Suggested profile match percentage
  static TextStyle suggestedMatchPercentage(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: _responsiveFontSize(
        context,
        heightFactor: 0.013,
        minSize: 10.0,
        maxSize: 11.0,
      ),
      fontWeight: FontWeight.w600,
      color: AppColors.primary,
    );
  }
}
