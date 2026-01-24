import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../bottomsheet/custom_bottom_sheet.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/rounded_button.dart';
import '../../../routes.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';
import '../bloc/registration_state.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _heightController = TextEditingController();

  String? _selectedGender;
  String? _selectedMaritalStatus;
  String? _selectedLocation;
  String? _selectedMotherTongue;
  List<String> _selectedLanguages = [];

  // Fixed height unit as per requirement
  int? _selectedHeight;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateState);
    _dobController.addListener(_updateState);
    _heightController.addListener(_updateState);

    // Load Master Data
    context.read<RegistrationBloc>().add(LoadMasterData());
  }

  void _updateState() {
    if (mounted) setState(() {});
  }

  bool get _isFormValid {
    // Basic validation, detailed validation on Next
    return _nameController.text.isNotEmpty &&
        _dobController.text.isNotEmpty &&
        _selectedHeight != null &&
        _selectedGender != null &&
        _selectedMaritalStatus != null &&
        _selectedLocation != null &&
        _selectedMotherTongue != null &&
        _selectedLanguages.isNotEmpty;
  }

  // Use generic for date picker
  void _showDatePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSizes.fieldRadius * 2),
            topRight: Radius.circular(AppSizes.fieldRadius * 2),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Date of Birth',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: AppColors.textSecondary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
                selectedDayHighlightColor: AppColors.primary,
                centerAlignModePicker: true,
                controlsHeight: 50,
                dayTextStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  color: AppColors.textPrimary,
                ),
                disabledDayTextStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  color: AppColors.textSecondary.withOpacity(0.5),
                ),
                currentDate: DateTime.now().subtract(
                  const Duration(days: 365 * 18),
                ),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                weekdayLabelTextStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
                controlsTextStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                yearTextStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  color: AppColors.textPrimary,
                ),
                selectedYearTextStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              value: _parseDateFromText(_dobController.text),
              onValueChanged: (dates) {
                if (dates.isNotEmpty && dates.first != null) {
                  final selectedDate = dates.first!;
                  setState(() {
                    _dobController.text =
                        '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
                  });
                  Navigator.pop(context);
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<DateTime?> _parseDateFromText(String text) {
    try {
      final parts = text.split('/');
      if (parts.length == 3) {
        final day = int.tryParse(parts[0]);
        final month = int.tryParse(parts[1]);
        final year = int.tryParse(parts[2]);

        if (day != null && month != null && year != null) {
          return [DateTime(year, month, day)];
        }
      }
    } catch (e) {}
    return [];
  }

  bool _isValidDate(String dateText) {
    try {
      final parts = dateText.split('/');
      if (parts.length != 3) return false;

      final day = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final year = int.tryParse(parts[2]);

      if (day == null || month == null || year == null) return false;
      if (month < 1 || month > 12) return false;
      if (day < 1 || day > 31) return false;

      final date = DateTime(year, month, day);
      return date.year == year && date.month == month && date.day == day;
    } catch (e) {
      return false;
    }
  }

  // --- Bottom Sheets with Dynamic Data ---

  void _showGenericSelectionSheet({
    required String title,
    required List<String> options,
    required String? selectedValue,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.disabled.withOpacity(0.5),
      builder: (context) => CustomBottomSheet.locationSelection(
        title: title,
        options: options,
        selectedValue: selectedValue,
        onSelect: onSelect,
        showSearch: true,
      ),
    );
  }

  void _showHeightSelectionSheet(List<int> heights) {
    final options = heights.map((h) => h.toString()).toList();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.disabled.withOpacity(0.5),
      builder: (context) => CustomBottomSheet.locationSelection(
        title: 'Select Height (cm)',
        options: options,
        selectedValue: _selectedHeight?.toString(),
        onSelect: (value) {
          setState(() {
            _selectedHeight = int.tryParse(value);
            _heightController.text = value; // Update controller
          });
        },
        showSearch: true,
      ),
    );
  }

  // Multi-select sheet for known languages
  void _showKnownLanguagesDynamic(List<String> options) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.disabled.withOpacity(0.5),
      builder: (context) => CustomBottomSheet.knownLanguages(
        options: options,
        selectedValues: _selectedLanguages,
        onSelect: (values) {
          setState(() {
            _selectedLanguages = values;
          });
        },
      ),
    );
  }

  void _handleNext() {
    if (!_isValidDate(_dobController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid date (dd/mm/yyyy)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedHeight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select valid height'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final details = {
      'name': _nameController.text.trim(),
      'dob': _dobController.text.trim(),
      'height': _selectedHeight.toString(),
      'heightUnit': 'cm',
      'gender': _selectedGender,
      'maritalStatus': _selectedMaritalStatus,
      'location': _selectedLocation,
      'motherTongue': _selectedMotherTongue,
      'knownLanguages': _selectedLanguages,
    };

    BlocProvider.of<RegistrationBloc>(
      context,
    ).add(PersonalDetailsUpdated(details));

    Navigator.of(context).pushNamed(Routes.religion);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        if (state.isLoadingMasterData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.masterDataError != null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.masterDataError}'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<RegistrationBloc>().add(LoadMasterData());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // Safe to render UI with state data
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's begin with you! Tell us a bit about yourself.",
                    style: AppTextStyles.heading(context),
                  ),
                  const SizedBox(height: 24),

                  // ORDER: Name -> DOB -> Height -> Gender -> Marital -> Location -> Mother Tongue -> Known Languages

                  // 1. Name
                  _buildSectionTitle('Name'),
                  _buildTextField(
                    hint: 'Type here',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 20),

                  // 2. Date of Birth
                  _buildSectionTitle('Date of Birth'),
                  _buildTextField(
                    hint: 'dd/mm/yyyy',
                    controller: _dobController,
                    readOnly: true,
                    onTap: _showDatePickerBottomSheet,
                  ),
                  const SizedBox(height: 20),

                  // 3. Height
                  _buildHeightSelectionField(state.heights),
                  const SizedBox(height: 20),

                  // 4. Gender
                  _buildGenderSelection(state.genders),
                  const SizedBox(height: 20),

                  // 5. Marital Status
                  _buildSelectionField(
                    title: 'Marital status',
                    value: _selectedMaritalStatus,
                    hint: 'Select',
                    onTap: () => _showGenericSelectionSheet(
                      title: 'Select Marital Status',
                      options: state.maritalStatuses,
                      selectedValue: _selectedMaritalStatus,
                      onSelect: (val) =>
                          setState(() => _selectedMaritalStatus = val),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 6. Current Location
                  _buildSelectionField(
                    title: 'Current location',
                    value: _selectedLocation,
                    hint: 'Select',
                    onTap: () => _showGenericSelectionSheet(
                      title: 'Select City',
                      options: state.cities.map((c) => c.name).toList(),
                      selectedValue: _selectedLocation,
                      onSelect: (val) =>
                          setState(() => _selectedLocation = val),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 7. Mother Tongue
                  _buildSelectionField(
                    title: 'Mother tongue',
                    value: _selectedMotherTongue,
                    hint: 'Select',
                    onTap: () => _showGenericSelectionSheet(
                      title: 'Select Mother Tongue',
                      options: state.motherTongues,
                      selectedValue: _selectedMotherTongue,
                      onSelect: (val) =>
                          setState(() => _selectedMotherTongue = val),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 8. Known Languages
                  _buildKnownLanguagesField(state.knownLanguages),

                  const SizedBox(height: 40),
                  RoundedButton(
                    label: 'Next',
                    onPressed: _isFormValid ? _handleNext : null,
                    isEnabled: _isFormValid,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(AppAssets.back),
        onPressed: () => Navigator.pop(context),
      ),
      // No title image in the provided design, just back button and text body
      // But keeping logo if user didn't ask to remove, they just said "order like UI"
      // The image shows "Profile Type" which might be the previous screen or title.
      // But let's stick to existing app bar style unless requested.
      // Actually image has NO logo in appbar, just back arrow.
      // For now, I will keep logo to not break consistency unless explicitly told.
      title: SvgPicture.asset(AppAssets.logo, height: 32),
      centerTitle: true,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onTap,
    bool readOnly = false,
  }) {
    final bool hasValue = controller.text.isNotEmpty;

    return Container(
      height: AppSizes.fieldHeight,
      decoration: BoxDecoration(
        color: AppColors.fieldBackground,
        borderRadius: BorderRadius.circular(AppSizes.fieldRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: controller,
                onTap: onTap,
                readOnly: readOnly,
                keyboardType: readOnly ? null : keyboardType,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: hasValue
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ),
          if (onTap != null)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Icon(
                  Icons.edit_calendar,
                  color: AppColors.textSecondary.withOpacity(0.5),
                  size: AppSizes.iconSizeMedium,
                ),
                onPressed: onTap,
                padding: EdgeInsets.zero,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectionField({
    required String title,
    required String? value,
    required String hint,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: AppSizes.fieldHeight,
            decoration: BoxDecoration(
              color: AppColors.fieldBackground,
              borderRadius: BorderRadius.circular(AppSizes.fieldRadius),
              border: Border.all(color: AppColors.border),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value ?? hint,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: value != null
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset(AppAssets.arrowDown),
                  padding: const EdgeInsets.all(8.0),
                  onPressed: onTap,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelection(List<String> genders) {
    // If genders is empty, fallback to default or show empty
    final options = genders.isEmpty ? ['Male', 'Female'] : genders;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Gender'),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            double itemWidth = (constraints.maxWidth - 14) / 2;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: options
                  .map((g) => _genderButton(g, itemWidth))
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _genderButton(String gender, double width) {
    final bool isSelected = _selectedGender == gender;
    String iconPath;
    if (gender.toLowerCase() == 'male')
      iconPath = AppAssets.male;
    else if (gender.toLowerCase() == 'female')
      iconPath = AppAssets.female;
    else
      iconPath = AppAssets.male;

    return SizedBox(
      width: width,
      height: 48,
      child: ElevatedButton(
        onPressed: () => setState(() => _selectedGender = gender),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          side: BorderSide(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              gender,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeightSelectionField(List<int> heights) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Height'),
        GestureDetector(
          onTap: () => _showHeightSelectionSheet(heights),
          child: Container(
            height: AppSizes.fieldHeight,
            decoration: BoxDecoration(
              color: AppColors.fieldBackground,
              borderRadius: BorderRadius.circular(AppSizes.fieldRadius),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                // LEFT UNIT BOX (CM + Arrow)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: AppColors.border),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "CM",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      SvgPicture.asset(
                        AppAssets.arrowDown,
                        width: 14,
                        height: 14,
                      ),
                    ],
                  ),
                ),

                // VALUE AREA
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      _selectedHeight != null
                          ? '$_selectedHeight'
                          : 'Select Height',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _selectedHeight != null
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKnownLanguagesField(List<String> languageOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Known languages'),
        GestureDetector(
          onTap: () => _showKnownLanguagesDynamic(languageOptions),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.fieldBackground,
              borderRadius: BorderRadius.circular(AppSizes.fieldRadius),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _selectedLanguages.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Select",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary.withOpacity(0.5),
                            ),
                          ),
                        )
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _selectedLanguages.map((lang) {
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    lang,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  GestureDetector(
                                    onTap: () {
                                      setState(
                                        () => _selectedLanguages.remove(lang),
                                      );
                                    },
                                    child: const Icon(Icons.close, size: 16),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                ),

                /// Drop arrow
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: SvgPicture.asset(AppAssets.arrowDown),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
