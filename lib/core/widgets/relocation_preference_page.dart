import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/radio_list_item.dart';

class RelocationPreferencePage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const RelocationPreferencePage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const options = [
    "I’m excited to move anywhere God leads us",
    "I’m open to moving within India",
    "I’d consider international opportunities (US/Canada/Australia)",
    "I prefer staying in my current region",
    "I prefer staying close to family and roots",
    "I’m flexible but would want to discuss together",
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
              "When it comes to relocating for work or family?",
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
