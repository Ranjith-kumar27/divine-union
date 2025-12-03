import 'package:flutter/material.dart';

/// Small wrapper for radio list item used on Profile Type and similar screens.
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

  @override
  Widget build(BuildContext context) {
    final bool selected = value == groupValue;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(fontFamily: 'Inter', fontSize: 15)),
      trailing: Radio<T>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
      tileColor: selected ? const Color(0xFFF5F3FF) : null,
    );
  }
}
