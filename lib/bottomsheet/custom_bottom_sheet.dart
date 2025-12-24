import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';

class CustomBottomSheet extends StatefulWidget {
  final String title;
  final List<String> options;
  final String? selectedValue;
  final List<String>? selectedValues;
  final Function(String) onSelect;
  final Function(List<String>)? onMultiSelect;
  final bool showSearch;
  final double heightFactor;
  final bool isMultiSelect;

  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.options,
    this.selectedValue,
    this.selectedValues,
    required this.onSelect,
    this.onMultiSelect,
    this.showSearch = false,
    this.heightFactor = 0.5,
    this.isMultiSelect = false,
  });

  // Factory constructor for marital status selection
  factory CustomBottomSheet.maritalStatus({
    required String? selectedValue,
    required Function(String) onSelect,
  }) {
    return CustomBottomSheet(
      title: 'Marital Status',
      options: const ['Single', 'Divorced', 'Widowed', 'Separated'],
      selectedValue: selectedValue,
      onSelect: onSelect,
      showSearch: false,
      heightFactor: 0.5,
    );
  }

  // Factory constructor for mother tongue selection
  factory CustomBottomSheet.motherTongue({
    required List<String> options,
    required String? selectedValue,
    required Function(String) onSelect,
  }) {
    return CustomBottomSheet(
      title: 'Select Mother Tongue',
      options: options,
      selectedValue: selectedValue,
      onSelect: onSelect,
      showSearch: false,
      // Changed from true to false
      heightFactor: 0.6,
    );
  }

  // Factory constructor for known languages selection (multi-select)
  factory CustomBottomSheet.knownLanguages({
    required List<String> options,
    required List<String> selectedValues,
    required Function(List<String>) onSelect,
  }) {
    return CustomBottomSheet(
      title: 'Select Known Languages',
      options: options,
      selectedValues: selectedValues,
      onSelect: (_) {},
      // Empty function since we use onMultiSelect
      onMultiSelect: onSelect,
      showSearch: false,
      // Changed from true to false
      heightFactor: 0.7,
      isMultiSelect: true,
    );
  }

  // Factory constructor for city/state/location selection
  factory CustomBottomSheet.locationSelection({
    required String title,
    required List<String> options,
    String? selectedValue,
    required Function(String) onSelect,
    bool showSearch = true,
    double heightFactor = 0.7,
  }) {
    return CustomBottomSheet(
      title: title,
      options: options,
      selectedValue: selectedValue,
      onSelect: onSelect,
      showSearch: showSearch,
      heightFactor: heightFactor,
    );
  }

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  late List<String> _filteredOptions;
  final TextEditingController _searchController = TextEditingController();
  List<String> _tempSelectedValues = [];

  @override
  void initState() {
    super.initState();
    _filteredOptions = List.from(widget.options);
    _tempSelectedValues = widget.selectedValues ?? [];
    if (widget.showSearch) {
      _searchController.addListener(_filterOptions);
    }
  }

  void _filterOptions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredOptions = widget.options
          .where((option) => option.toLowerCase().contains(query))
          .toList();
    });
  }

  void _handleMultiSelect(String value) {
    setState(() {
      if (_tempSelectedValues.contains(value)) {
        _tempSelectedValues.remove(value);
      } else {
        _tempSelectedValues.add(value);
      }
    });
  }

  void _applyMultiSelection() {
    if (widget.onMultiSelect != null) {
      widget.onMultiSelect!(_tempSelectedValues);
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    if (widget.showSearch) {
      _searchController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.darken),
      child: Container(
        height: MediaQuery.of(context).size.height * widget.heightFactor,
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
            // Draggable indicator at the top center
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.16,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        borderRadius: BorderRadius.circular(
                          AppSizes.fieldRadius,
                        ),
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
                      padding: const EdgeInsets.all(0.0),
                      itemCount: _filteredOptions.length,
                      itemBuilder: (context, index) {
                        final option = _filteredOptions[index];
                        final isSelected = widget.isMultiSelect
                            ? _tempSelectedValues.contains(option)
                            : widget.selectedValue == option;

                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: index == 0
                                  ? BorderSide.none
                                  : BorderSide(
                                      color: AppColors.border,
                                      width: 0.5,
                                    ),
                              bottom: BorderSide(
                                color: AppColors.border,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0.0,
                              vertical: 0.0,
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
                                        ? AppColors.primary
                                        : AppColors.textSecondary,
                                  ),
                                ),
                                trailing: widget.isMultiSelect
                                    ? Checkbox(
                                        value: isSelected,
                                        onChanged: (_) =>
                                            _handleMultiSelect(option),
                                        activeColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4.0,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        // This is the corrected radio button
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isSelected
                                                ? AppColors.primary
                                                : AppColors.border,
                                            width: 2,
                                          ),
                                          color: isSelected
                                              ? AppColors.primary
                                              : Colors.transparent,
                                        ),
                                        child: isSelected
                                            ? const Icon(
                                                Icons.circle,
                                                size: 12,
                                                color: Colors.white,
                                              )
                                            : null,
                                      ),
                                onTap: widget.isMultiSelect
                                    ? () => _handleMultiSelect(option)
                                    : () {
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

            // Apply button for multi-select
            if (widget.isMultiSelect) ...[
              const Divider(height: 1, color: AppColors.border),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: AppSizes.buttonHeight,
                  child: ElevatedButton(
                    onPressed: _applyMultiSelection,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.buttonRadius,
                        ),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Apply',
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
        width: 22, // Changed from dynamic size to fixed 22
        height: 22, // Changed from dynamic size to fixed 22
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 2,
          ),
          color: isSelected ? AppColors.primary : Colors.transparent,
        ),
        child: isSelected
            ? const Icon(Icons.circle, size: 12, color: Colors.white)
            : null,
      ),
    );
  }
}

class CircleRadioButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onTap;
  final double size;

  const CircleRadioButton({
    super.key,
    required this.isSelected,
    this.onTap,
    this.size = 22.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 2,
          ),
          color: isSelected ? AppColors.primary : Colors.transparent,
        ),
        child: isSelected
            ? Icon(
                Icons.circle,
                size: size * 0.545,
                color: Colors.white,
              ) // 12/22 ≈ 0.545
            : null,
      ),
    );
  }
}
