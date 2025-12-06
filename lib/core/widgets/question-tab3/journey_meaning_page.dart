import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/radio_list_item.dart';

class JourneyMeaningPage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const JourneyMeaningPage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const journeyOptions = [
    "Connect me with people who share my denominational background",
    "Show me profiles of those with similar career ambitions",
    "Prioritize matches based on spiritual compatibility",
    "Include people open to relocating to my preferred areas",
    "Help me find someone with complementary personality traits",
    "Match me with people who share similar interests",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            "How can we make your journey on Divine Union most meaningful?",
            style: AppTextStyles.heading(context),
          ),

          const SizedBox(height: AppSizes.largeSpacing),

          /// Radio options list (same UI as previous page)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: journeyOptions.length,
            separatorBuilder: (_, __) =>
                const Divider(height: 0, color: AppColors.border),
            itemBuilder: (_, index) {
              return RadioListItem<String>(
                value: journeyOptions[index],
                groupValue: selectedValue,
                label: journeyOptions[index],
                onChanged: onSelected,
              );
            },
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
