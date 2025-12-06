import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/radio_list_item.dart';

class PartnerHeightPage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const PartnerHeightPage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const options = [
    "4'0\" - 4'5\" (122-135 cm)",
    "4'6\" - 4'11\" (137-150 cm)",
    "5'0\" - 5'5\" (152-165 cm)",
    "5'6\" - 5'11\" (168-180 cm)",
    "6'0\" - 6'5\" (183-196 cm)",
    "6'6\" and above (198+ cm)",
    "No specific preference",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Height preference for your partner",
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