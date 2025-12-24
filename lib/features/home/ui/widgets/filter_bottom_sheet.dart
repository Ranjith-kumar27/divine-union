import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // Dummy State for filters
  RangeValues _ageRange = const RangeValues(18, 60);
  RangeValues _heightRange = const RangeValues(4.0, 7.0);

  // Selections
  final Set<String> _maritalStatus = {};
  final Set<String> _location = {};
  final Set<String> _denomination = {};
  final Set<String> _churchAttendance = {};
  final Set<String> _educationLevel = {};
  final Set<String> _diet = {};
  final Set<String> _drinking = {};
  final Set<String> _smoking = {};
  final Set<String> _languages = {};
  final Set<String> _familyType = {};

  // Expanded states for sections
  final Map<String, bool> _expandedSections = {
    'Basic Preferences': true,
    'Faith & Church': false,
    'Education & Career': false,
    'Lifestyle': false,
    'Languages': false,
    'Family Background': false,
  };

  void _toggleSection(String title) {
    setState(() {
      _expandedSections[title] = !(_expandedSections[title] ?? false);
    });
  }

  bool get _hasActiveFilters {
    bool rangesChanged =
        _ageRange != const RangeValues(18, 60) ||
        _heightRange != const RangeValues(4.0, 7.0);

    return rangesChanged ||
        _maritalStatus.isNotEmpty ||
        _location.isNotEmpty ||
        _denomination.isNotEmpty ||
        _churchAttendance.isNotEmpty ||
        _educationLevel.isNotEmpty ||
        _diet.isNotEmpty ||
        _drinking.isNotEmpty ||
        _smoking.isNotEmpty ||
        _languages.isNotEmpty ||
        _familyType.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                children: [
                  _buildSection(
                    title: 'Basic Preferences',
                    content: _buildBasicPreferences(),
                  ),
                  _buildSection(
                    title: 'Faith & Church',
                    content: _buildFaithAndChurch(),
                  ),
                  _buildSection(
                    title: 'Education & Career',
                    content: _buildEducation(),
                  ),
                  _buildSection(title: 'Lifestyle', content: _buildLifestyle()),
                  _buildSection(title: 'Languages', content: _buildLanguages()),
                  _buildSection(
                    title: 'Family Background',
                    content: _buildFamilyBackground(),
                  ),
                  const SizedBox(height: 100), // Space for bottom buttons
                ],
              ),
            ),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filters',
                style: AppTextStyles.heading(context).copyWith(fontSize: 24),
              ),
              const SizedBox(height: 4),
              Text(
                '${_calculateActiveCount()} filters active',
                style: AppTextStyles.body(context).copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.close,
                color: Color(0xFF6B7280),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget content}) {
    final isExpanded = _expandedSections[title] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => _toggleSection(title),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: isExpanded ? AppColors.liteDisabled : Colors.transparent,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    title,
                    style: AppTextStyles.subheading(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isExpanded
                          ? AppColors.primary
                          : const Color(0xFF374151),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: isExpanded
                        ? AppColors.primary
                        : const Color(0xFF9CA3AF),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: content,
            ),
        ],
      ),
    );
  }

  Widget _buildBasicPreferences() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildRangeSlider(
          title: 'Age Range',
          values: _ageRange,
          min: 18,
          max: 60,
          label: '${_ageRange.start.round()} - ${_ageRange.end.round()} yrs',
          onChanged: (v) => setState(() => _ageRange = v),
        ),
        const SizedBox(height: 24),
        _buildRangeSlider(
          title: 'Height Range',
          values: _heightRange,
          min: 4.0,
          max: 7.0,
          label:
              '${_heightRange.start.toStringAsFixed(1)}" - ${_heightRange.end.toStringAsFixed(1)}"',
          onChanged: (v) => setState(() => _heightRange = v),
        ),
        const SizedBox(height: 24),
        _buildSelectionGroup(
          title: 'Marital Status',
          options: const ['Never Married', 'Divorced', 'Widowed'],
          selected: _maritalStatus,
          onSelect: (val) {
            setState(() {
              if (_maritalStatus.contains(val)) {
                _maritalStatus.remove(val);
              } else {
                _maritalStatus.add(val);
              }
            });
          },
        ),
        const SizedBox(height: 24),
        _buildSelectionGroup(
          title: 'Location',
          options: const [
            'Chennai',
            'Coimbatore',
            'Hyderabad',
            'Bangalore',
            'Madurai',
          ],
          selected: _location,
          onSelect: (val) {
            setState(() {
              if (_location.contains(val)) {
                _location.remove(val);
              } else {
                _location.add(val);
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildFaithAndChurch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildSelectionGroup(
          title: 'Denomination',
          options: const [
            'Protestant',
            'Catholic',
            'Orthodox',
            'Pentecostal',
            'CSI',
            'Any',
          ],
          selected: _denomination,
          onSelect: (val) => _toggleSelection(_denomination, val),
        ),
        const SizedBox(height: 24),
        _buildSelectionGroup(
          title: 'Church Attendance',
          options: const ['Weekly', 'Bi-weekly', 'Monthly', 'Occasionally'],
          selected: _churchAttendance,
          onSelect: (val) => _toggleSelection(_churchAttendance, val),
        ),
      ],
    );
  }

  Widget _buildEducation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildSelectionGroup(
          title: 'Education Level',
          options: const [
            'Bachelor\'s',
            'Master\'s',
            'Professional Degree',
            'Doctorate',
            'High School',
          ],
          selected: _educationLevel,
          onSelect: (val) => _toggleSelection(_educationLevel, val),
        ),
      ],
    );
  }

  Widget _buildLifestyle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildSelectionGroup(
          title: 'Diet',
          options: const [
            'Vegetarian',
            'Non-Vegetarian',
            'Eggetarian',
            'Vegan',
          ],
          selected: _diet,
          onSelect: (val) => _toggleSelection(_diet, val),
        ),
        const SizedBox(height: 24),
        _buildSelectionGroup(
          title: 'Drinking',
          options: const [
            'Non-Drinker',
            'Occasional Drinker',
            'Social Drinker',
          ],
          selected: _drinking,
          onSelect: (val) => _toggleSelection(_drinking, val),
        ),
        const SizedBox(height: 24),
        _buildSelectionGroup(
          title: 'Smoking',
          options: const ['Non-Smoker', 'Occasional Smoker', 'Regular Smoker'],
          selected: _smoking,
          onSelect: (val) => _toggleSelection(_smoking, val),
        ),
      ],
    );
  }

  Widget _buildLanguages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildSelectionGroup(
          title: 'Known Languages',
          options: const ['Tamil', 'English', 'Malayalam', 'Kannada', 'Hindi'],
          selected: _languages,
          onSelect: (val) => _toggleSelection(_languages, val),
        ),
      ],
    );
  }

  Widget _buildFamilyBackground() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildSelectionGroup(
          title: 'Family Type',
          options: const ['Nuclear', 'Joint', 'Extended'],
          selected: _familyType,
          onSelect: (val) => _toggleSelection(_familyType, val),
        ),
      ],
    );
  }

  Widget _buildRangeSlider({
    required String title,
    required RangeValues values,
    required double min,
    required double max,
    required String label,
    required ValueChanged<RangeValues> onChanged,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: const Color(0xFFE5E7EB),
            thumbColor: AppColors.primary,
            trackHeight: 4,
            overlayShape: SliderComponentShape.noOverlay,
          ),
          child: RangeSlider(
            values: values,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionGroup({
    required String title,
    required List<String> options,
    required Set<String> selected,
    required ValueChanged<String> onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4B5563),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selected.contains(option);
            return GestureDetector(
              onTap: () => onSelect(option),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : const Color(0xFFD1D5DB),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF374151),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: _resetAll,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFFF9FAFB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Reset All',
                style: TextStyle(
                  color: Color(0xFF4B5563),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, _calculateActiveCount()),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: _hasActiveFilters
                    ? AppColors.primary
                    : const Color(0xFFA5A6F6),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Apply',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleSelection(Set<String> set, String value) {
    setState(() {
      if (set.contains(value)) {
        set.remove(value);
      } else {
        set.add(value);
      }
    });
  }

  void _resetAll() {
    setState(() {
      _ageRange = const RangeValues(18, 60);
      _heightRange = const RangeValues(4.0, 7.0);
      _maritalStatus.clear();
      _location.clear();
      _denomination.clear();
      _churchAttendance.clear();
      _educationLevel.clear();
      _diet.clear();
      _drinking.clear();
      _smoking.clear();
      _languages.clear();
      _familyType.clear();
    });
  }

  int _calculateActiveCount() {
    int count = 0;
    count += _maritalStatus.length;
    count += _location.length;
    count += _denomination.length;
    count += _churchAttendance.length;
    count += _educationLevel.length;
    count += _diet.length;
    count += _drinking.length;
    count += _smoking.length;
    count += _languages.length;
    count += _familyType.length;

    if (_ageRange != const RangeValues(18, 60)) count++;
    if (_heightRange != const RangeValues(4.0, 7.0)) count++;

    return count;
  }
}
