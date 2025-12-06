import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

class JoyInLifePageTwo extends StatefulWidget {
  final List<String> selectedItems;
  final ValueChanged<List<String>> onSelectionChanged;

  const JoyInLifePageTwo({
    super.key,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  State<JoyInLifePageTwo> createState() => _JoyInLifePageTwoState();
}

class _JoyInLifePageTwoState extends State<JoyInLifePageTwo> {
  static const int _maxSelection = 3;

  final List<String> options = [
    'Outgoing and social',
    'Thoughtful and reflective',
    'Funny and lighthearted',
    'Caring and compassionate',
    'Ambitious and driven',
    'Creative and artistic',
    'Practical and organized',
    'Adventurous and spontaneous',
    'Patient and understanding',
    'Loyal and dependable',
  ];

  late List<String> selected;

  @override
  void initState() {
    super.initState();
    selected = List.from(widget.selectedItems);
  }

  void toggleSelect(String item) {
    setState(() {
      if (selected.contains(item)) {
        selected.remove(item);
      } else {
        if (selected.length >= _maxSelection) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Maximum 3 options allowed")),
          );
          return;
        }
        selected.add(item);
      }
      widget.onSelectionChanged(List.from(selected));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ---- Title ----
          Text(
            'What brings you joy in life?',
            style: AppTextStyles.heading(context),
          ),

          const SizedBox(height: AppSizes.smallSpacing),

          Text(
            'Maximum of $_maxSelection can be selected',
            style: AppTextStyles.bold(
              context,
            ).copyWith(color: AppColors.textSecondary),
          ),

          const SizedBox(height: AppSizes.largeSpacing),

          /// ---- Selectable List ----
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (_, index) {
              final item = options[index];
              final isSelected = selected.contains(item);

              return Column(
                children: [
                  InkWell(
                    onTap: () => toggleSelect(item),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withOpacity(0.08)
                            : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item,
                              style: AppTextStyles.body(context)!.copyWith(
                                color: isSelected
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              ),
                            ),
                          ),

                          /// checkbox box
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                width: 1.2,
                              ),
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.transparent,
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0, color: AppColors.border),
                ],
              );
            },
          ),

          const SizedBox(height: 90),
        ],
      ),
    );
  }
}
