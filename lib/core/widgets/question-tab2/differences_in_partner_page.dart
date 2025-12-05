import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

class DifferencesInPartnerPage extends StatefulWidget {
  final String? selectedValue;
  final ValueChanged<String?> onSelectionChanged;

  const DifferencesInPartnerPage({
    super.key,
    required this.selectedValue,
    required this.onSelectionChanged,
  });

  @override
  State<DifferencesInPartnerPage> createState() =>
      _DifferencesInPartnerPageState();
}

class _DifferencesInPartnerPageState extends State<DifferencesInPartnerPage> {
  final List<_SelectableOption> options = const [
    _SelectableOption('I\'m open to different denominational backgrounds'),
    _SelectableOption('I\'m flexible about different regional cultures'),
    _SelectableOption(
      'I appreciate different personality types that complement mine',
    ),
    _SelectableOption(
      'I\'m interested in partners from different educational backgrounds',
      emphasize: true,
    ),
    _SelectableOption('I welcome different career paths and ambitions'),
    _SelectableOption('I\'m open to different dietary preferences'),
    _SelectableOption('I\'m comfortable with age differences'),
  ];

  late String? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selectedValue;
  }

  void select(String value) {
    setState(() {
      selected = value == selected ? null : value;
      widget.onSelectionChanged(selected);
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
            'When it comes to differences in your partner?',
            style: AppTextStyles.heading(context),
          ),

          const SizedBox(height: AppSizes.mediumSpacing),

          /// List items
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (_, index) {
              final item = options[index];
              final isSelected = selected == item.label;

              return Column(
                children: [
                  InkWell(
                    onTap: () => select(item.label),
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

                          /// Radio UI
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                width: 1.4,
                              ),
                            ),
                            child: isSelected
                                ? Center(
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
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

          const SizedBox(height: 90), // Safe bottom
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
