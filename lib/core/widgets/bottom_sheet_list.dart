import 'package:flutter/material.dart';

/// Generic bottom sheet list with top grabber used for marital status and similar pickers.
class BottomSheetList extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const BottomSheetList({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 420,
        child: Column(
          children: [
            const SizedBox(height: 8),
            Container(width: 60, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4))),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemBuilder: (c, i) {
                  return ListTile(
                    title: Text(options[i]),
                    trailing: i == selectedIndex ? const Icon(Icons.check, color: Color(0xFF6A6AF0)) : null,
                    onTap: () {
                      onSelect(i);
                      Navigator.of(context).pop();
                    },
                  );
                },
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemCount: options.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
