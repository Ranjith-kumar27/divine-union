import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool enabled;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool fullWidth;
  final double? height;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.enabled = true,
    this.backgroundColor,
    this.foregroundColor,
    this.fullWidth = true,
    this.height,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || !enabled;

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: height ?? AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled
              ? AppColors.disabled
              : backgroundColor ?? AppColors.primary,
          foregroundColor: isDisabled
              ? AppColors.textSecondary
              : foregroundColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              leadingIcon!,
              const SizedBox(width: AppSizes.smallSpacing),
            ],
            Text(text, style: AppTextStyles.buttonLabel(context)),
            if (trailingIcon != null) ...[
              const SizedBox(width: AppSizes.smallSpacing),
              trailingIcon!,
            ],
          ],
        ),
      ),
    );
  }
}
