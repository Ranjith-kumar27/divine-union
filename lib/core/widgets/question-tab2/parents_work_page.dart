import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_text_styles.dart';

class ParentsWorkPage extends StatefulWidget {
  final String? fatherOccupation;
  final String? motherOccupation;
  final Function(String father, String mother) onChanged;

  const ParentsWorkPage({
    super.key,
    this.fatherOccupation,
    this.motherOccupation,
    required this.onChanged,
  });

  @override
  State<ParentsWorkPage> createState() => _ParentsWorkPageState();
}

class _ParentsWorkPageState extends State<ParentsWorkPage> {
  late TextEditingController _fatherCtrl;
  late TextEditingController _motherCtrl;
  bool _isFatherFocused = false;
  bool _isMotherFocused = false;

  @override
  void initState() {
    super.initState();
    _fatherCtrl = TextEditingController(text: widget.fatherOccupation ?? "");
    _motherCtrl = TextEditingController(text: widget.motherOccupation ?? "");
  }

  void _update() {
    widget.onChanged(_fatherCtrl.text.trim(), _motherCtrl.text.trim());
    setState(() {}); // refresh next button state
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: AppSizes.screenTopSpacing),

          // Main heading - Using the same style as mobile_number_screen
          Text(
            "Tell us about your parent's work",
            style: AppTextStyles.heading(context), // Same as journeyStartsHere
          ),
          const SizedBox(height: AppSizes.largeSpacing),

          // Father's Occupation
          Text(
            "Father's Occupation",
            style: AppTextStyles.label(
              context,
            ).copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppSizes.smallSpacing),

          // Father's input field
          Container(
            height: AppSizes.fieldHeight,
            decoration: BoxDecoration(
              border: Border.all(
                color: _isFatherFocused ? AppColors.primary : AppColors.border,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(AppSizes.fieldRadius),
              color: AppColors.fieldBackground,
            ),
            child: Focus(
              onFocusChange: (focus) {
                setState(() {
                  _isFatherFocused = focus;
                });
              },
              child: TextField(
                controller: _fatherCtrl,
                onChanged: (_) => _update(),
                style: AppTextStyles.bold(
                  context,
                ).copyWith(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type here",
                  hintStyle: AppTextStyles.bold(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.mediumSpacing,
                    vertical: AppSizes.mediumSpacing,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.largeSpacing),

          // Mother's Occupation
          Text(
            "Mother's Occupation",
            style: AppTextStyles.label(
              context,
            ).copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppSizes.smallSpacing),

          // Mother's input field
          Container(
            height: AppSizes.fieldHeight,
            decoration: BoxDecoration(
              border: Border.all(
                color: _isMotherFocused ? AppColors.primary : AppColors.border,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(AppSizes.fieldRadius),
              color: AppColors.fieldBackground,
            ),
            child: Focus(
              onFocusChange: (focus) {
                setState(() {
                  _isMotherFocused = focus;
                });
              },
              child: TextField(
                controller: _motherCtrl,
                onChanged: (_) => _update(),
                style: AppTextStyles.bold(
                  context,
                ).copyWith(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type here",
                  hintStyle: AppTextStyles.bold(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.mediumSpacing,
                    vertical: AppSizes.mediumSpacing,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.largeSpacing * 2),
        ],
      ),
    );
  }
}
