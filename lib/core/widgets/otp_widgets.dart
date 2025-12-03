import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';
import '../constants/app_text_styles.dart';

/// Reusable OTP input field widget
class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool hasFocus;
  final bool hasText;
  final bool isFirstField;
  final bool isLastField;
  final ValueChanged<String>? onChanged;

  const OtpInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hasFocus,
    required this.hasText,
    required this.isFirstField,
    required this.isLastField,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Determine border color based on focus and text
    final Color borderColor = hasFocus || hasText ? AppColors.primary : AppColors.border;

    return Container(
      width: AppSizes.otpFieldSize,
      height: AppSizes.otpFieldSize + 8,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: hasFocus ? 1 : 1.5,
        ),
        borderRadius: BorderRadius.only(
          topLeft: isFirstField ? Radius.circular(AppSizes.fieldRadius) : Radius.zero,
          bottomLeft: isFirstField ? Radius.circular(AppSizes.fieldRadius) : Radius.zero,
          topRight: isLastField ? Radius.circular(AppSizes.fieldRadius) : Radius.zero,
          bottomRight: isLastField ? Radius.circular(AppSizes.fieldRadius) : Radius.zero,
        ),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: AppTextStyles.otpField(context),
          maxLength: 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: '',
            contentPadding: EdgeInsets.zero,
            hintText: hasFocus ? '' : '*',
            hintStyle: AppTextStyles.otpField(context).copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

/// OTP field row widget with joined fields (no spacing)
class OtpFieldRow extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final ValueChanged<String>? onFieldChanged;
  final ValueChanged<int>? onFieldChangedWithIndex;
  final int fieldCount;

  const OtpFieldRow({
    super.key,
    required this.controllers,
    required this.focusNodes,
    this.onFieldChanged,
    this.onFieldChangedWithIndex,
    this.fieldCount = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.otpFieldSize + 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(fieldCount, (index) {
          // Calculate if this is first or last field
          final bool isFirstField = index == 0;
          final bool isLastField = index == fieldCount - 1;

          // Remove right border except for last field
          final bool hasRightBorder = !isLastField;

          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: hasRightBorder
                      ? BorderSide(
                    color: AppColors.border,
                    width: 0.0,
                  )
                      : BorderSide.none,
                ),
              ),
              child: OtpInputField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                hasFocus: focusNodes[index].hasFocus,
                hasText: controllers[index].text.isNotEmpty,
                isFirstField: isFirstField,
                isLastField: isLastField,
                onChanged: (value) {
                  onFieldChanged?.call(value);
                  onFieldChangedWithIndex?.call(index);
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Timer widget for OTP resend
class OtpTimerWidget extends StatelessWidget {
  final int remainingSeconds;
  final VoidCallback onResend;
  final bool canResend;

  const OtpTimerWidget({
    super.key,
    required this.remainingSeconds,
    required this.onResend,
    this.canResend = false,
  });

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSecs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSecs';
  }

  @override
  Widget build(BuildContext context) {
    return canResend
        ? GestureDetector(
      onTap: onResend,
      child: Text(
        AppStrings.resendCode,
        style: AppTextStyles.resendCode(context),
      ),
    )
        : Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.resendCodeIn,
          style: AppTextStyles.label(context).copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(width: 4),
        Text(
          _formatTime(remainingSeconds),
          style: AppTextStyles.resendCode(context),
        ),
      ],
    );
  }
}
