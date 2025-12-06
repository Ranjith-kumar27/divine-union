import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';

class MarriedLifeVisionPage extends StatefulWidget {
  final List<String> selectedItems;
  final ValueChanged<List<String>> onSelectionChanged;

  const MarriedLifeVisionPage({
    super.key,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  State<MarriedLifeVisionPage> createState() => _MarriedLifeVisionPageState();
}

class _MarriedLifeVisionPageState extends State<MarriedLifeVisionPage> {
  final List<String> options = const [
    "Building a Christ-centered home filled with love and laughter",
    "Supporting each other's dreams while serving God together",
    "Creating a family legacy of faith for future generations",
    "Balancing career success with deep spiritual connection",
    "Being actively involved in church and community ministry",
    "Traveling and experiencing God's creation together",
    "Focusing on simple joys and contentment together",
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
          /// Title
          Text(
            "What's your vision for married life together?",
            style: AppTextStyles.heading(context),
          ),
          const SizedBox(height: AppSizes.smallSpacing),
          Text(
            'Select all that apply',
            style: AppTextStyles.bold(context).copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSizes.largeSpacing),

          /// Options list with divider like other screens
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
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
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