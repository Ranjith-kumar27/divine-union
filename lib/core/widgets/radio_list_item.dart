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
            fontWeight: FontWeight.w400,
            color: selected
                ? AppColors.textPrimary  // Selected color
                : AppColors.textSecondary, // Unselected color
          ),
        ),
        trailing: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: 2.0,
            ),
          ),
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: selected ? 12.0 : 0,
              height: selected ? 12.0 : 0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors.primary : Colors.transparent,
              ),
            ),
          ),
        ),
        tileColor: selected ? AppColors.liteDisabled : null,
        onTap: () => onChanged(value),
      ),
    );
  }
}