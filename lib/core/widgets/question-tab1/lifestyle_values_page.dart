import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';

class LifestyleValuesPage extends StatefulWidget {
  final List<String> selectedValues;
  final ValueChanged<List<String>> onSelectionChanged;

  const LifestyleValuesPage({
    super.key,
    required this.selectedValues,
    required this.onSelectionChanged,
  });

  @override
  State<LifestyleValuesPage> createState() => _LifestyleValuesPageState();
}

class _LifestyleValuesPageState extends State<LifestyleValuesPage> {
  static const List<String> options = [
    "Staying healthy and active is really important to me",
    "I’m pretty careful about what movies/music/content I let into my life",
    "I love keeping our family and cultural traditions going",
    "I get excited about new experiences, travel, and trying different foods",
    "I like keeping things simple and not too cluttered or complicated",
    "Taking care of the environment matters to me - I try to live responsibly",
    "I’m definitely more of an introvert who recharges at home",
    "I’m pretty extroverted and love being social with people",
    "I love having people over and making my home welcoming",
    "I’m always reading, learning, or picking up new hobbies",
    "I can be pretty spontaneous and love unplanned adventures",
    "I like having structure and planning things out ahead of time",
  ];

  void _toggleSelection(String item) {
    final list = List<String>.from(widget.selectedValues);

    if (list.contains(item)) {
      list.remove(item);
    } else {
      if (list.length >= 5) return; // max 5
      list.add(item);
    }

    widget.onSelectionChanged(list);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's talk about other lifestyle choices that reflect your values",
            style: AppTextStyles.heading(context),
          ),

          const SizedBox(height: AppSizes.mediumSpacing),

          Text(
            "Maximum of 5 can be selected",
            style: AppTextStyles.bold(
              context,
            ).copyWith(color: AppColors.textSecondary),
          ),

          const SizedBox(height: AppSizes.largeSpacing),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (_, index) {
              final item = options[index];
              final isSelected = widget.selectedValues.contains(item);

              return Column(
                children: [
                  InkWell(
                    onTap: () => setState(() => _toggleSelection(item)),
                    child: Container(
                      color: isSelected
                          ? AppColors.liteDisabled
                          : Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      // small spacing so background visible
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              child: Text(
                                item,
                                style: AppTextStyles.bold(context)!.copyWith(
                                  color: isSelected
                                      ? AppColors.textPrimary
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                          Checkbox(
                            value: isSelected,
                            activeColor: AppColors.primary,
                            onChanged: (_) =>
                                setState(() => _toggleSelection(item)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Divider
                  const Divider(height: 0, color: AppColors.border),
                ],
              );
            },
          ),

          const SizedBox(height: 80), // space at bottom for Next button
        ],
      ),
    );
  }
}
