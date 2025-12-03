import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import '../../../bottomsheet/custom_bottom_sheet.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/rounded_button.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';

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

  final List<String> _genderOptions = ['Male', 'Female'];
  final List<String> _maritalOptions = [
    'Single',
    'Divorced',
    'Widowed',
    'Separated',
  ];
  final List<String> _locationOptions = [
    'Chennai',
    'Coimbatore',
    'Madurai',
    'Tiruchirappalli',
    'Salem',
    'Tirunelveli',
    'Erode',
    'Vellore',
    'Thoothukkudi',
    'Dindigul',
    'Thanjavur',
    'Hosur',
    'Nagercoil',
    'Kanchipuram',
    'Kumarapalayam',
    'Karaikkudi',
    'Neyveli',
    'Cuddalore',
    'Ambur',
    'Pollachi',
    'Rajapalayam',
    'Sivakasi',
    'Pudukkottai',
    'Vaniyambadi',
    'Nagapattinam',
    'Gudiyatham',
    'Dharmapuri',
    'Kumbakonam',
    'Tiruvannamalai',
    'Palladam',
    'Arakkonam',
    'Ariyalur',
    'Coonoor',
    'Dharapuram',
    'Manapparai',
    'Mayiladuthurai',
    'Mettur',
    'Mettupalayam',
    'Panruti',
    'Pattukkottai',
    'Perambalur',
    'Puliyankudi',
    'Rasipuram',
    'Sankari',
    'Sathyamangalam',
    'Sivaganga',
    'Thiruvarur',
    'Udumalaipettai',
    'Valparai',
    'Vedaranyam',
    'Viluppuram',
    'Virudhunagar',
  ];
  final List<String> _motherTongueOptions = [
    'Tamil',
    'Telugu',
    'Malayalam',
    'Hindi',
    'English',
    'Kannada',
  ];
  final List<String> _languageOptions = [
    'Tamil',
    'English',
    'Hindi',
    'Telugu',
    'Malayalam',
    'Kannada',
    'Bengali',
    'Gujarati',
    'Marathi',
    'Other',
  ];

  bool get _isFormValid {
    return _nameController.text.isNotEmpty &&
        _dobController.text.isNotEmpty &&
        _heightController.text.isNotEmpty &&
        _selectedGender != null &&
        _selectedMaritalStatus != null &&
        _selectedLocation != null &&
        _selectedMotherTongue != null &&
        _selectedLanguages.isNotEmpty;
  }

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
                currentDate: DateTime.now().subtract(const Duration(days: 365 * 18)), // Default to 18 years ago
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
    } catch (e) {
      // If parsing fails, return empty list
    }
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

      // Check for valid days in month
      final date = DateTime(year, month, day);
      return date.year == year && date.month == month && date.day == day;
    } catch (e) {
      return false;
    }
  }

  void _showSelectionBottomSheet({
    required String title,
    required List<String> options,
    required String? selectedValue,
    required Function(String) onSelect,
    bool showSearch = false,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomBottomSheet(
        title: title,
        options: options,
        selectedValue: selectedValue,
        onSelect: onSelect,
        showSearch: showSearch,
      ),
    );
  }

  void _showMultiSelectionBottomSheet({
    required String title,
    required List<String> options,
    required List<String> selectedValues,
    required Function(List<String>) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomBottomSheet.multiSelect(
        title: title,
        options: options,
        selectedValues: selectedValues,
        onSelect: onSelect,
      ),
    );
  }

  void _handleNext() {
    if (!_isValidDate(_dobController.text.trim())) {
      // Show error if date is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid date (dd/mm/yyyy)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final details = {
      'name': _nameController.text.trim(),
      'dob': _dobController.text.trim(),
      'height': _heightController.text.trim(),
      'gender': _selectedGender,
      'maritalStatus': _selectedMaritalStatus,
      'location': _selectedLocation,
      'motherTongue': _selectedMotherTongue,
      'knownLanguages': _selectedLanguages,
    };

    BlocProvider.of<RegistrationBloc>(
      context,
    ).add(PersonalDetailsUpdated(details));
    // Navigator.of(context).pushNamed(Routes.religion);
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
    VoidCallback? onTap,
    bool readOnly = false,
  }) {
    return Container(
      height: AppSizes.fieldHeight,
      decoration: BoxDecoration(
        color: AppColors.fieldBackground,
        borderRadius: BorderRadius.circular(AppSizes.fieldRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onTap: onTap,
              readOnly: readOnly,
              keyboardType: readOnly ? null : TextInputType.datetime, // Allow typing for date
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.0,
                  color: AppColors.textSecondary,
                ),
              ),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (onTap != null)
            IconButton(
              icon: Icon(
                Icons.edit_calendar,
                color: AppColors.textSecondary,
                size: AppSizes.iconSizeMedium,
              ),
              onPressed: onTap,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value ?? hint,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      color: value != null
                          ? AppColors.textPrimary
                          : AppColors.textSecondary.withOpacity(0.7),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.textSecondary,
                    size: AppSizes.iconSizeLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Gender'),
        Row(
          children: _genderOptions.map((gender) {
            final isSelected = _selectedGender == gender;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGender = gender;
                    });
                  },
                  child: Container(
                    height: AppSizes.fieldHeight,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withOpacity(0.1)
                          : AppColors.fieldBackground,
                      borderRadius: BorderRadius.circular(AppSizes.fieldRadius),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                        width: isSelected ? 2.0 : 1.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        gender,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLanguageChips() {
    if (_selectedLanguages.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: _selectedLanguages.map((language) {
          return Chip(
            label: Text(
              language,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.0,
                color: AppColors.textPrimary,
              ),
            ),
            backgroundColor: AppColors.primary.withOpacity(0.1),
            deleteIcon: Icon(
              Icons.close,
              size: AppSizes.iconSizeSmall,
              color: AppColors.textSecondary,
            ),
            onDeleted: () {
              setState(() {
                _selectedLanguages.remove(language);
              });
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 80,
        leading: Container(
          margin: const EdgeInsets.only(left: 8.0, top: 6.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border, width: 1.0),
          ),
          child: IconButton(
            icon: SvgPicture.asset(
              AppAssets.arrowRight,
              color: AppColors.textPrimary,
            ),
            onPressed: () => Navigator.of(context).pop(),
            padding: const EdgeInsets.all(8.0),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.screenTopSpacing),
              // Heading
              Text(
                "Let's begin with you! Tell us a bit about yourself.",
                style: AppTextStyles.heading(context),
              ),
              const SizedBox(height: AppSizes.largeSpacing),

              // Name Field
              _buildSectionTitle('Name'),
              _buildTextField(
                hint: 'Type here',
                controller: _nameController,
              ),
              const SizedBox(height: AppSizes.largeSpacing),

              // Date of Birth Field
              _buildSectionTitle('Date of Birth'),
              _buildTextField(
                hint: 'dd/mm/yyyy',
                controller: _dobController,
                onTap: _showDatePickerBottomSheet,
                readOnly: false, // Changed to false to allow typing
              ),
              const SizedBox(height: AppSizes.largeSpacing),

              // Height Field
              _buildSectionTitle('Height'),
              _buildTextField(
                hint: 'ft',
                controller: _heightController,
              ),
              const SizedBox(height: AppSizes.largeSpacing),

              // Gender Selection
              _buildGenderSelection(),
              const SizedBox(height: AppSizes.largeSpacing),

              // Marital Status
              _buildSelectionField(
                title: 'Marital status',
                value: _selectedMaritalStatus,
                hint: 'Select',
                onTap: () => _showSelectionBottomSheet(
                  title: 'Marital Status',
                  options: _maritalOptions,
                  selectedValue: _selectedMaritalStatus,
                  onSelect: (value) {
                    setState(() {
                      _selectedMaritalStatus = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: AppSizes.largeSpacing),

              // Current Location
              _buildSelectionField(
                title: 'Current location',
                value: _selectedLocation,
                hint: 'Select',
                onTap: () => _showSelectionBottomSheet(
                  title: 'Select City',
                  options: _locationOptions,
                  selectedValue: _selectedLocation,
                  onSelect: (value) {
                    setState(() {
                      _selectedLocation = value;
                    });
                  },
                  showSearch: true,
                ),
              ),
              const SizedBox(height: AppSizes.largeSpacing),

              // Mother Tongue
              _buildSelectionField(
                title: 'Mother tongue',
                value: _selectedMotherTongue,
                hint: 'Select',
                onTap: () => _showSelectionBottomSheet(
                  title: 'Mother Tongue',
                  options: _motherTongueOptions,
                  selectedValue: _selectedMotherTongue,
                  onSelect: (value) {
                    setState(() {
                      _selectedMotherTongue = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: AppSizes.largeSpacing),

              // Known Languages
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Known languages'),
                  GestureDetector(
                    onTap: () => _showMultiSelectionBottomSheet(
                      title: 'Known Languages',
                      options: _languageOptions,
                      selectedValues: _selectedLanguages,
                      onSelect: (values) {
                        setState(() {
                          _selectedLanguages = values;
                        });
                      },
                    ),
                    child: Container(
                      height: AppSizes.fieldHeight,
                      decoration: BoxDecoration(
                        color: AppColors.fieldBackground,
                        borderRadius: BorderRadius.circular(
                          AppSizes.fieldRadius,
                        ),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedLanguages.isNotEmpty
                                  ? _selectedLanguages.join(', ')
                                  : 'Select',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16.0,
                                color: _selectedLanguages.isNotEmpty
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary.withOpacity(0.7),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.textSecondary,
                              size: AppSizes.iconSizeLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildLanguageChips(),
                ],
              ),
              const SizedBox(height: AppSizes.largeSpacing),

              // Next Button - Fixed parameters
              RoundedButton(
                label: AppStrings.next,
                onPressed: _isFormValid ? _handleNext : null,
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
                height: AppSizes.buttonHeight,
                borderRadius: AppSizes.buttonRadius,
                isEnabled: _isFormValid,
              ),
              const SizedBox(height: AppSizes.largeSpacing),
            ],
          ),
        ),
      ),
    );
  }
}
