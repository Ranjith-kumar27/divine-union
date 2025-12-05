import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class RadioListItem<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final ValueChanged<T?> onChanged;

  const RadioListItem({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  });

  bool get selected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(color: AppColors.border, width: 0.5),
          bottom: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        title: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: selected
                ? AppColors.textPrimary  // Selected color
                : AppColors.textSecondary, // Unselected color
          ),
        ),
        trailing: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: 2,
            ),
            color: selected ? AppColors.primary : Colors.transparent,
          ),
          child: selected
              ? const Icon(Icons.circle, size: 12, color: Colors.white)
              : null,
        ),
        tileColor: selected ? AppColors.liteDisabled : null,
        onTap: () => onChanged(value),
      ),
    );
  }
}