import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/radio_list_item.dart';

class SiblingsPage extends StatefulWidget {
  final String? selectedValue;
  final int marriedCount;
  final int unmarriedCount;

  final Function(String value) onSelected;
  final Function(int married, int unmarried) onSiblingCountChanged;

  const SiblingsPage({
    super.key,
    this.selectedValue,
    this.marriedCount = 0,
    this.unmarriedCount = 0,
    required this.onSelected,
    required this.onSiblingCountChanged,
  });

  @override
  State<SiblingsPage> createState() => _SiblingsPageState();
}

class _SiblingsPageState extends State<SiblingsPage> {
  String? selected;

  late TextEditingController marriedCtrl;
  late TextEditingController unmarriedCtrl;

  final siblingsOptions = ["Brother", "Sister", "Both"];

  @override
  void initState() {
    selected = widget.selectedValue;
    marriedCtrl = TextEditingController(text: widget.marriedCount.toString());
    unmarriedCtrl = TextEditingController(text: widget.unmarriedCount.toString());
    super.initState();
  }

  void updateCounts() {
    widget.onSiblingCountChanged(
      int.tryParse(marriedCtrl.text) ?? 0,
      int.tryParse(unmarriedCtrl.text) ?? 0,
    );
  }

  Widget countBox(String label, TextEditingController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 15)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          onChanged: (_) => updateCounts(),
          decoration: InputDecoration(
            hintText: "0",
            filled: true,
            fillColor: AppColors.fieldBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.border),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Heading (Same style as sample)
          Text("Do you have siblings?", style: AppTextStyles.heading(context)),
          const SizedBox(height: AppSizes.largeSpacing),

          /// Radio list UI matched to sample
          ListView.separated(
            itemCount: siblingsOptions.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) =>
            const Divider(height: 0, color: AppColors.border),
            itemBuilder: (_, index) {
              final option = siblingsOptions[index];
              return RadioListItem<String>(
                value: option,
                groupValue: selected,
                label: option,
                onChanged: (v) {
                  setState(() => selected = v);
                  widget.onSelected(v!);
                },
              );
            },
          ),

          const SizedBox(height: 12),

          /// Fields visible only when selected "Both"
          if (selected == "Both") ...[
            countBox("How many are married?", marriedCtrl),
            countBox("How many are unmarried?", unmarriedCtrl),
          ],

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
