import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/radio_list_item.dart';

class InvolvementPage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const InvolvementPage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const options = ['Yes', 'No'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Are you involved in any church activities or ministries?',
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
