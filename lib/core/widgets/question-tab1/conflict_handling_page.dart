import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../radio_list_item.dart';

class ConflictHandlingPage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const ConflictHandlingPage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const List<String> options = [
    "I prefer calm, open conversation",
    "I like to pray about it first, then discuss",
    "I appreciate when others help mediate",
    "I need some time to think before talking",
    "I believe in addressing issues quickly and directly",
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
              "How do you handle disagreements or conflicts?",
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