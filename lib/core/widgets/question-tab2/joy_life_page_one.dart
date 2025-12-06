import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';

class JoyInLifePageOne extends StatefulWidget {
  final List<String> selectedItems;
  final ValueChanged<List<String>> onSelectionChanged;

  const JoyInLifePageOne({
    super.key,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  State<JoyInLifePageOne> createState() => _JoyInLifePageOneState();
}

class _JoyInLifePageOneState extends State<JoyInLifePageOne> {
  static const int maxSelection = 5;

  final List<String> interests = [
    "Worship and praise music",
    "Cooking and sharing meals",
    "Reading and learning new things",
    "Traveling and exploring new places",
    "Sports and outdoor activities",
    "Art, music or creative hobbies",
    "Time with family and friends",
    "Movies, books and entertainment",
    "Photography and nature",
    "Dancing and cultural programs",
    "Technology and gadgets",
  ];

  late List<String> selectedList;

  @override
  void initState() {
    super.initState();
    selectedList = List.from(widget.selectedItems);
  }

  void toggleSelect(String item) {
    setState(() {
      if (selectedList.contains(item)) {
        selectedList.remove(item);
      } else {
        if (selectedList.length >= maxSelection) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Maximum of 5 options allowed")),
          );
          return;
        }
        selectedList.add(item);
      }

      widget.onSelectionChanged(List.from(selectedList));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// -------- TITLE --------
          Text(
            "What brings you joy in life?",
            style: AppTextStyles.heading(context),
          ),

          const SizedBox(height: AppSizes.smallSpacing),

          Text(
            "Maximum of 5 can be selected",
            style: AppTextStyles.bold(context)
                .copyWith(color: AppColors.textSecondary),
          ),

          const SizedBox(height: AppSizes.largeSpacing),

          /// -------- OPTIONS LIST --------
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: interests.length,
            itemBuilder: (_, index) {
              final item = interests[index];
              final isSelected = selectedList.contains(item);

              return Column(
                children: [
                  InkWell(
                    onTap: () => toggleSelect(item),
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 4),
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
                                fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                              ),
                            ),
                          ),
                          Checkbox(
                            value: isSelected,
                            activeColor: AppColors.primary,
                            onChanged: (_) => toggleSelect(item),
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
