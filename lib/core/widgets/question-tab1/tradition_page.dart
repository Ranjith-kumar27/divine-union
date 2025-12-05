import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/widgets/radio_list_item.dart';

class TraditionPage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const TraditionPage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const traditions = [
    'Roman Catholic',
    'Protestant (Pentecostal/Evangelical)',
    'Orthodox (Syrian/Jacobite/Mar Thoma)',
    'Methodist',
    'Lutheran',
    'Baptist',
    'Presbyterian',
    'Independent/Non-denominational',
    'Still exploring different traditions',
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
              'Which Christian tradition feels most like home to you?',
              style: AppTextStyles.heading(context),
            ),
          ),
          const SizedBox(height: AppSizes.largeSpacing),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: traditions.length,
            separatorBuilder: (_, __) =>
            const Divider(height: 0, color: AppColors.border),
            itemBuilder: (context, index) => RadioListItem<String>(
              value: traditions[index],
              groupValue: selectedValue,
              label: traditions[index],
              onChanged: onSelected,
            ),
          ),
        ],
      ),
    );
  }
}
