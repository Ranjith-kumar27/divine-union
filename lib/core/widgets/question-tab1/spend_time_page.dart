import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/widgets/radio_list_item.dart';

class SpendTimePage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const SpendTimePage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const spendTimeOptions = [
    "Daily personal prayer and Bible reading",
    "Attending church services regularly",
    "Joining Bible study or small groups",
    "Listening to worship music and Christian podcasts",
    "Serving others through ministry",
    "Fellowship with other believers",
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
              "How do you like to spend time with God?",
              style: AppTextStyles.heading(context),
            ),
          ),
          const SizedBox(height: AppSizes.largeSpacing),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: spendTimeOptions.length,
            separatorBuilder: (_, __) =>
            const Divider(height: 0, color: AppColors.border),
            itemBuilder: (context, index) => RadioListItem<String>(
              value: spendTimeOptions[index],
              groupValue: selectedValue,
              label: spendTimeOptions[index],
              onChanged: onSelected,
            ),
          ),
        ],
      ),
    );
  }
}
