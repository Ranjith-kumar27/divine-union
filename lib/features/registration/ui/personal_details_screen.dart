import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../bottomsheet/custom_bottom_sheet.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/rounded_button.dart';
import '../../../routes.dart';
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
        _isValidHeight(_heightController.text.trim()) &&
        _selectedGender != null &&
        _selectedMaritalStatus != null &&
        _selectedLocation != null &&
        _selectedMotherTongue != null &&
        _selectedLanguages.isNotEmpty;
  }

  bool _isValidHeight(String heightText) {
    final height = double.tryParse(heightText);
    return height != null && height > 0;
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

      final date = DateTime(year, month, day);
      return date.year == year && date.month == month && date.day == day;
    } catch (e) {
      return false;
    }
  }

  void _showMaritalStatusBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.disabled.withOpacity(0.5),
      builder: (context) => CustomBottomSheet.maritalStatus(
        selectedValue: _selectedMaritalStatus,
        onSelect: (value) {
          setState(() {
            _selectedMaritalStatus = value;
          });
        },
      ),
    );
  }

  void _showLocationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.disabled.withOpacity(0.5),
      builder: (context) => CustomBottomSheet.locationSelection(
        title: 'Select City',
        options: _locationOptions,
        selectedValue: _selectedLocation,
        onSelect: (selected) {
          setState(() {
            _selectedLocation = selected;
          });
        },
      ),
    );
  }

  void _showMotherTongueBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.disabled.withOpacity(0.5),
      builder: (context) => CustomBottomSheet.motherTongue(
        options: _motherTongueOptions,
        selectedValue: _selectedMotherTongue,
        // Changed from selectedValues to selectedValue
        onSelect: (selected) {
          // Changed from onSelect to accept String instead of List<String>
          setState(() {
            _selectedMotherTongue = selected;
          });
        },
      ),
    );
  }

  void _showKnownLanguagesBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomBottomSheet.knownLanguages(
        options: _languageOptions,
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

    if (!_isValidHeight(_heightController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid height'),
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

    // Dispatch the event to update the state
    BlocProvider.of<RegistrationBloc>(
      context,
    ).add(PersonalDetailsUpdated(details));

    // Navigate to the next screen
    Navigator.of(context).pushNamed(Routes.religion);
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: controller,
                onTap: onTap,
                readOnly: readOnly,
                keyboardType: readOnly ? null : TextInputType.datetime,
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
                  color: AppColors.textPrimary,
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
                          : AppColors.textSecondary.withOpacity(0.5),
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
                padding: const EdgeInsets.only(right: 28.0),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 18.0),
                        Icon(
                          gender == 'Male' ? Icons.male : Icons.female,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          size: AppSizes.iconSizeMedium,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          gender,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
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

  Widget _buildHeightField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Height'),
        Row(
          children: [
            Container(
              height: AppSizes.fieldHeight,
              width: 60,
              decoration: BoxDecoration(
                color: AppColors.fieldBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.fieldRadius),
                  bottomLeft: Radius.circular(AppSizes.fieldRadius),
                ),
                border: Border.all(color: AppColors.border),
              ),
              child: Center(
                child: Text(
                  'ft',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: AppSizes.fieldHeight,
                decoration: BoxDecoration(
                  color: AppColors.fieldBackground,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppSizes.fieldRadius),
                    bottomRight: Radius.circular(AppSizes.fieldRadius),
                  ),
                  border: Border(
                    top: BorderSide(color: AppColors.border),
                    right: BorderSide(color: AppColors.border),
                    bottom: BorderSide(color: AppColors.border),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _heightController,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '',
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
                    ],
                  ),
                ),
              ),
            ),
          ],
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

  Widget _buildKnownLanguagesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Known languages'),
        GestureDetector(
          onTap: _showKnownLanguagesBottomSheet,
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
                    _selectedLanguages.isNotEmpty
                        ? _selectedLanguages.join(', ')
                        : 'Select',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: _selectedLanguages.isNotEmpty
                          ? AppColors.textPrimary
                          : AppColors.textSecondary.withOpacity(0.5),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset(AppAssets.arrowDown),
                  onPressed: _showKnownLanguagesBottomSheet,
                  padding: const EdgeInsets.all(8.0),
                ),
              ],
            ),
          ),
        ),
        _buildLanguageChips(),
      ],
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
              Text(
                "Let's begin with you! Tell us a bit about yourself.",
                style: AppTextStyles.heading(context),
              ),
              const SizedBox(height: AppSizes.largeSpacing),

              _buildSectionTitle('Name'),
              _buildTextField(hint: 'Type here', controller: _nameController),
              const SizedBox(height: AppSizes.largeSpacing),

              _buildSectionTitle('Date of Birth'),
              _buildTextField(
                hint: 'dd/mm/yyyy',
                controller: _dobController,
                onTap: _showDatePickerBottomSheet,
                readOnly: false,
              ),
              const SizedBox(height: AppSizes.largeSpacing),

              _buildHeightField(),
              const SizedBox(height: AppSizes.largeSpacing),

              _buildGenderSelection(),
              const SizedBox(height: AppSizes.largeSpacing),

              _buildSelectionField(
                title: 'Marital status',
                value: _selectedMaritalStatus,
                hint: 'Select',
                onTap: _showMaritalStatusBottomSheet,
              ),
              const SizedBox(height: AppSizes.largeSpacing),

              _buildSelectionField(
                title: 'Current location',
                value: _selectedLocation,
                hint: 'Select',
                onTap: _showLocationBottomSheet,
              ),
              const SizedBox(height: AppSizes.largeSpacing),

              _buildSelectionField(
                title: 'Mother tongue',
                value: _selectedMotherTongue,
                hint: 'Select',
                onTap: _showMotherTongueBottomSheet,
              ),
              const SizedBox(height: AppSizes.largeSpacing),

              _buildKnownLanguagesField(),
              const SizedBox(height: AppSizes.largeSpacing),

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
