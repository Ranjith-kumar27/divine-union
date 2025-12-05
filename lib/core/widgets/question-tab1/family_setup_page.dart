import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../radio_list_item.dart';

class FamilySetupPage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const FamilySetupPage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const options = [
    "Joint Family (living with extended family)",
    "Nuclear Family (parents and siblings only)",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "What type of family setup do you come from?",
              style: AppTextStyles.heading(context),
            ),
          ),
          const SizedBox(height: AppSizes.largeSpacing),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            separatorBuilder: (_, __) =>
                const Divider(height: 0, color: AppColors.border),
            itemBuilder: (context, index) => RadioListItem<String>(
              value: options[index],
              groupValue: selectedValue,
              label: options[index],
              onChanged: onSelected,
            ),
          ),
        ],
      ),
    );
  }
}
