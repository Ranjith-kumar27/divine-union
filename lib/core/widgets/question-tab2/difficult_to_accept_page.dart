import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

class DifficultToAcceptPage extends StatefulWidget {
  final List<String> selectedItems;
  final ValueChanged<List<String>> onSelectionChanged;

  const DifficultToAcceptPage({
    super.key,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  State<DifficultToAcceptPage> createState() => _DifficultToAcceptPageState();
}

class _DifficultToAcceptPageState extends State<DifficultToAcceptPage> {
  final List<_SelectableOption> options = const [
    _SelectableOption('Regular alcohol consumption'),
    _SelectableOption('Smoking or tobacco use'),
    _SelectableOption(
      'Very different faith commitment levels',
      emphasize: true,
    ),
    _SelectableOption('Unwillingness to have children'),
    _SelectableOption('Unwillingness to relocate when needed'),
    _SelectableOption('Little interest in family involvement'),
    _SelectableOption('Vastly different career ambitions', emphasize: true),
    _SelectableOption('Different views on church involvement'),
    _SelectableOption('Limited interest in serving others'),
    _SelectableOption('Significantly different educational background'),
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
            'Which of these would be difficult for you to accept?',
            style: AppTextStyles.heading(context),
          ),

          const SizedBox(height: AppSizes.smallSpacing),

          Text(
            'Select all that apply',
            style: AppTextStyles.bold(
              context,
            ).copyWith(color: AppColors.textSecondary),
          ),

          const SizedBox(height: AppSizes.largeSpacing),

          /// Options list with divider like other screens
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

class _SelectableOption {
  final String label;
  final bool emphasize;

  const _SelectableOption(this.label, {this.emphasize = false});
}
