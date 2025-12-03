import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_sizes.dart';

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

  const RoundedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
    this.width,
    this.backgroundColor,
    this.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    final buttonChild = SizedBox(
      height: AppSizes.buttonHeight,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? (backgroundColor ?? AppColors.primary)
              : (disabledColor ?? AppColors.disabled),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          ),
        ),
        child:Text(
          label,
          style: AppTextStyles.buttonLabel(context).copyWith(
            color: isEnabled ? Colors.white : Colors.grey.shade400,
          ),
        ),
      ),
    );

    return buttonChild;
  }
}