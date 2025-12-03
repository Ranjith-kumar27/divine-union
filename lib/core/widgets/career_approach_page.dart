import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/radio_list_item.dart';

class CareerApproachPage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const CareerApproachPage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const options = [
    "Very ambitious - career is a top priority",
    "Balanced - both career and family matter equally",
    "Family-focused - career supports our family goals",
    "Service-oriented - work is my way of serving God",
    "Still figuring out my path",
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
              "How would you describe your approach to career and work?",
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
