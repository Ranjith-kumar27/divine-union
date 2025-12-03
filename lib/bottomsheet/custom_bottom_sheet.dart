import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';

class CustomBottomSheet extends StatefulWidget {
  final String title;
  final List<String> options;
  final String? selectedValue;
  final Function(String) onSelect;
  final bool showSearch;

  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.options,
    this.selectedValue,
    required this.onSelect,
    this.showSearch = false,
  });

  factory CustomBottomSheet.multiSelect({
    required String title,
    required List<String> options,
    required List<String> selectedValues,
    required Function(List<String>) onSelect,
    bool showSearch = false,
  }) {
    return _MultiSelectBottomSheet(
      title: title,
      options: options,
      selectedValues: selectedValues,
      onMultiSelect: onSelect,
      showSearch: showSearch,
    );
  }

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  late List<String> _filteredOptions;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredOptions = List.from(widget.options);
    _searchController.addListener(_filterOptions);
  }

  void _filterOptions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredOptions = widget.options
          .where((option) => option.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.textSecondary,
                        size: 24.0,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                if (widget.showSearch) ...[
                  Container(
                    height: AppSizes.fieldHeight,
                    decoration: BoxDecoration(
                      color: AppColors.fieldBackground,
                      borderRadius: BorderRadius.circular(AppSizes.fieldRadius),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(
                            Icons.search,
                            color: AppColors.textSecondary,
                            size: 20.0,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search your city',
                              hintStyle: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16.0,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16.0,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),

          // Options List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _filteredOptions.length,
              itemBuilder: (context, index) {
                final option = _filteredOptions[index];
                final isSelected = widget.selectedValue == option;

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  title: Text(
                    option,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(
                    Icons.check,
                    color: AppColors.primary,
                    size: 20.0,
                  )
                      : null,
                  onTap: () {
                    widget.onSelect(option);
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MultiSelectBottomSheet extends CustomBottomSheet {
  final List<String> selectedValues;
  final Function(List<String>) onMultiSelect;

  _MultiSelectBottomSheet({
    required String title,
    required List<String> options,
    required this.selectedValues,
    required this.onMultiSelect,
    bool showSearch = false,
  }) : super(
    title: title,
    options: options,
    selectedValue: null,
    onSelect: (_) {},
    showSearch: showSearch,
  );

  @override
  State<CustomBottomSheet> createState() => _MultiSelectBottomSheetState();
}

class _MultiSelectBottomSheetState extends State<_MultiSelectBottomSheet> {
  late List<String> _selectedValues;
  late List<String> _filteredOptions;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedValues = List.from(widget.selectedValues);
    _filteredOptions = List.from((widget as _MultiSelectBottomSheet).options);
    _searchController.addListener(_filterOptions);
  }

  void _filterOptions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredOptions = (widget as _MultiSelectBottomSheet).options
          .where((option) => option.toLowerCase().contains(query))
          .toList();
    });
  }

  void _toggleSelection(String value) {
    setState(() {
      if (_selectedValues.contains(value)) {
        _selectedValues.remove(value);
      } else {
        _selectedValues.add(value);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.textSecondary,
                        size: 24.0,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                if (widget.showSearch) ...[
                  const SizedBox(height: 8.0),
                  Container(
                    height: AppSizes.fieldHeight,
                    decoration: BoxDecoration(
                      color: AppColors.fieldBackground,
                      borderRadius: BorderRadius.circular(AppSizes.fieldRadius),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(
                            Icons.search,
                            color: AppColors.textSecondary,
                            size: 20.0,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16.0,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16.0,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),

          // Options List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _filteredOptions.length,
              itemBuilder: (context, index) {
                final option = _filteredOptions[index];
                final isSelected = _selectedValues.contains(option);

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  title: Text(
                    option,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (_) => _toggleSelection(option),
                    activeColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  onTap: () => _toggleSelection(option),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                );
              },
            ),
          ),

          // Done Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  (widget as _MultiSelectBottomSheet).onMultiSelect(_selectedValues);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  elevation: 0,
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
