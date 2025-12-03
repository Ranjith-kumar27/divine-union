import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/radio_list_item.dart';

class AttendancePage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const AttendancePage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const attendanceOptions = [
    'Weekly (almost every Sunday)',
    'Biweekly (2-3 times a month)',
    'Monthly (once a month)',
    'Occasionally (festivals & special occasions)',
    'Rarely',
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
              'How often do you attend church services?',
              style: AppTextStyles.heading(context),
            ),
          ),
          const SizedBox(height: AppSizes.largeSpacing),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: attendanceOptions.length,
            separatorBuilder: (_, __) =>
            const Divider(height: 0, color: AppColors.border),
            itemBuilder: (context, index) => RadioListItem<String>(
              value: attendanceOptions[index],
              groupValue: selectedValue,
              label: attendanceOptions[index],
              onChanged: onSelected,
            ),
          ),
        ],
      ),
    );
  }
}
