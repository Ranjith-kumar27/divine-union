import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/radio_list_item.dart';

class FamilyApprovalImportancePage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const FamilyApprovalImportancePage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const options = [
    "Essential my family's blessing means everything",
    "Very important I value their wisdom and support",
    "Somewhat important I respect their input",
    "Not crucial this is ultimately my decision",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("How important is family approval in your marriage decision?",
              style: AppTextStyles.heading(context)),
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
