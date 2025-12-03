import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/radio_list_item.dart';

class FaithJourneyPage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const FaithJourneyPage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const faithJourneyOptions = [
    "Growing stronger every day through prayer and study",
    "Steady in my faith, seeking to deepen it further",
    "Learning and discovering what faith means to me",
    "Strong foundation, looking to serve God together with someone",
    "Questioning and exploring my faith",
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
              "Tell us about your relationship with God - where you are in your faith journey?",
              style: AppTextStyles.heading(context),
            ),
          ),
          const SizedBox(height: AppSizes.largeSpacing),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: faithJourneyOptions.length,
            separatorBuilder: (_, __) =>
            const Divider(height: 0, color: AppColors.border),
            itemBuilder: (context, index) => RadioListItem<String>(
              value: faithJourneyOptions[index],
              groupValue: selectedValue,
              label: faithJourneyOptions[index],
              onChanged: onSelected,
            ),
          ),
        ],
      ),
    );
  }
}
