import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

class LifePartnerValuesPage extends StatefulWidget {
  final List<String> selectedItems;
  final ValueChanged<List<String>> onSelectionChanged;

  const LifePartnerValuesPage({
    super.key,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  State<LifePartnerValuesPage> createState() => _LifePartnerValuesPageState();
}

class _LifePartnerValuesPageState extends State<LifePartnerValuesPage> {
  static const int _maxSelection = 5;

  final List<_SelectableOption> options = const [
    _SelectableOption('Deep personal faith and relationship with God'),
    _SelectableOption('Active in church and ministry'),
    _SelectableOption('Kind, caring, and emotionally mature', emphasize: true),
    _SelectableOption('Shares similar life goals and values'),
    _SelectableOption('Supportive of career and personal growth'),
    _SelectableOption('Great communication and conflict resolution skills'),
    _SelectableOption('Family-oriented and respects elders', emphasize: true),
    _SelectableOption('Financially responsible and stable'),
    _SelectableOption('Fun-loving with similar interests'),
    _SelectableOption('Open to growing and learning together'),
    _SelectableOption('Physically attractive and health-conscious'),
    _SelectableOption('Educated and intellectually compatible'),
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
            const SnackBar(content: Text("Maximum 5 options allowed")),
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
          /// Title
          Text(
            'What matters most to you in a life partner?',
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

          /// List Builder Section
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (_, index) {
              final item = options[index];
              final isSelected = selected.contains(item.label);

              return Column(
                children: [
                  InkWell(
                    onTap: () => toggleSelect(item.label),
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
                              item.label,
                              style: AppTextStyles.body(context)!.copyWith(
                                color: isSelected
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              ),
                            ),
                          ),

                          /// checkbox style
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

          const SizedBox(height: 90), // Bottom safe spacing
        ],
      ),
    );
  }
}

class _SelectableOption {
  final String label;
  final bool emphasize;

  const _SelectableOption(this.label, {this.emphasize = false});
}
