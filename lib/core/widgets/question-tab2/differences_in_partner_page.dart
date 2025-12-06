import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/radio_list_item.dart';

class DifferencesInPartnerPage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelectionChanged;

  const DifferencesInPartnerPage({
    super.key,
    required this.selectedValue,
    required this.onSelectionChanged,
  });

  static const options = [
    "I'm open to different denominational backgrounds",
    "I'm flexible about different regional cultures",
    "I appreciate different personality types that complement mine",
    "I'm interested in partners from different educational backgrounds",
    "I welcome different career paths and ambitions",
    "I'm open to different dietary preferences",
    "I'm comfortable with age differences",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "When it comes to differences in your partner?",
            style: AppTextStyles.heading(context),
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
                onChanged: onSelectionChanged,
              );
            },
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
