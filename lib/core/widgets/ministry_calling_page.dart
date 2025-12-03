import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/radio_list_item.dart';

class MinistryCallingPage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const MinistryCallingPage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const options = [
    "Yes, I have a clear calling",
    "I’m exploring different ways to serve",
    "Not sure yet, but open to discovering",
    "No specific calling at this time",
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
              "Do you feel called to any specific ministry or service?",
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
