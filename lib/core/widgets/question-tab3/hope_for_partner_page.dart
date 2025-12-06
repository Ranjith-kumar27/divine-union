import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/radio_list_item.dart';

class HopeForPartnerPage extends StatelessWidget {
  final String? selectedValue; // <- Single value
  final ValueChanged<String?> onSelected;

  const HopeForPartnerPage({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  static const options = [
    "I trust God's timing and plan for my life",
    "I believe there's someone who will love and accept me completely",
    "I'm excited about growing in faith together with someone special",
    "I look forward to building a beautiful family together",
    "I'm ready to love and support my future spouse wholeheartedly",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "One more thing - what gives you hope about finding your life partner?",
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
