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
    return BackdropFilter(
      filter: ColorFilter.mode(
        Colors.black.withOpacity(0.5), // Adjust opacity for blur effect
        BlendMode.darken,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5, // Fixed height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
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
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.16,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
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
                  ],
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),

            // Options List
            Expanded(
              child: _filteredOptions.isEmpty
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'No results found',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _filteredOptions.length,
                itemBuilder: (context, index) {
                  final option = _filteredOptions[index];
                  final isSelected = widget.selectedValue == option;

                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: index == 0
                            ? BorderSide.none
                            : BorderSide(color: AppColors.border, width: 0.5),
                        bottom: BorderSide(color: AppColors.border, width: 0.5),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: Material(
                        color: isSelected
                            ? AppColors.liteDisabled
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                        child: ListTile(
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
                              color: isSelected
                                  ? AppColors.textPrimary  // Selected - text primary color
                                  : AppColors.textSecondary, // Unselected - muted color
                            ),
                          ),
                          trailing: DesignRadioButton<String>(
                            value: option,
                            groupValue: widget.selectedValue,
                            onChanged: (value) {
                              if (value != null) {
                                widget.onSelect(value);
                                Navigator.pop(context);
                              }
                            },
                            size: 24.0,
                          ),
                          onTap: () {
                            widget.onSelect(option);
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DesignRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final double size;

  const DesignRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.size = 24.0,
  });

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? AppColors.primary  // Primary color when selected
                : AppColors.border,   // Border color when unselected
            width: 2.0,
          ),
        ),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? size * 0.5 : 0,
            height: isSelected ? size * 0.5 : 0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppColors.primary : Colors.transparent,
            ),
          ),
        ),
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
    _filteredOptions = List.from((widget).options);
    _searchController.addListener(_filterOptions);
  }

  void _filterOptions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredOptions = (widget).options
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
    return BackdropFilter(
      filter: ColorFilter.mode(
        Colors.black.withOpacity(0.5), // Background blur effect
        BlendMode.darken,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8, // Fixed height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
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
              child: _filteredOptions.isEmpty
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'No results found',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _filteredOptions.length,
                itemBuilder: (context, index) {
                  final option = _filteredOptions[index];
                  final isSelected = _selectedValues.contains(option);

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: Material(
                      color: isSelected
                          ? AppColors.disabled // Changed to disabled background
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        title: Text(
                          option,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary, // Set text color
                          ),
                        ),
                        trailing: Checkbox(
                          value: isSelected,
                          onChanged: (_) => _toggleSelection(option),
                          activeColor: AppColors.primary, // Set checkbox color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        onTap: () => _toggleSelection(option),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
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
                    (widget).onMultiSelect(_selectedValues);
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
      ),
    );
  }
}
