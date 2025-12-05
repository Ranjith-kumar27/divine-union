import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/radio_list_item.dart';

class FamilyDynamicPage extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const FamilyDynamicPage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const options = [
    "Joint family living with parents and relatives",
    "Nuclear family with regular extended family involvement",
    "Independent living with family visits and celebrations",
    "Flexible approach based on circumstances",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("What kind of family dynamic do you envision after marriage?",
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
