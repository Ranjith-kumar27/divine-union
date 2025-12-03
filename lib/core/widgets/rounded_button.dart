import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';

/// Reusable primary button matching Figma:
/// - Height: 48px
/// - Radius: 8px
/// - Background: #6A6AF0
/// - Text style: Inter 16, semi-bold
class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final double? width; // default to full width
  final Color? backgroundColor;
  final Color? disabledColor;
  final Color? textColor; // Added parameter
  final double? height; // Added parameter
  final double? borderRadius; // Added parameter

  const RoundedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
    this.width,
    this.backgroundColor,
    this.disabledColor,
    this.textColor, // Added
    this.height, // Added
    this.borderRadius, // Added
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = height ?? AppSizes.buttonHeight;
    final buttonRadius = borderRadius ?? AppSizes.buttonRadius;
    final buttonTextColor = textColor ?? Colors.white;

    return SizedBox(
      height: buttonHeight,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? (backgroundColor ?? AppColors.primary)
              : (disabledColor ?? AppColors.disabled),
          foregroundColor: buttonTextColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.buttonLabel(
            context,
          ).copyWith(color: isEnabled ? buttonTextColor : Colors.grey.shade400),
        ),
      ),
    );
  }
}
