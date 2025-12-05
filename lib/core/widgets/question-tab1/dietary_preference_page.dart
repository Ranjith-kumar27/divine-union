import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/radio_list_item.dart';

class DietaryPreferencePage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const DietaryPreferencePage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const options = [
    "Vegetarian",
    "Non Vegetarian",
    "Eggtarian (Vegetarian + Eggs)",
    "No specific preference",
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
              "What are your dietary preferences?",
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
            itemBuilder: (_, index) {
              return RadioListItem<String>(
                value: options[index],
                groupValue: selectedValue,
                label: options[index],
                onChanged: onSelected,
              );
            },
          ),
        ],
      ),
    );
  }
}
