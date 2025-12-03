import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/dropdown_field.dart';
import '../../../core/widgets/rounded_button.dart';
import '../../../core/widgets/bottom_sheet_list.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});
  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _name = TextEditingController();
  final _dob = TextEditingController();
  final _height = TextEditingController();
  String? _gender;
  String? _marital;
  String? _city;
  String? _motherTongue;
  List<String> _knownLanguages = [];

  final maritalOptions = ['Single', 'Divorced', 'Widowed', 'Separated'];
  final genderOptions = ['Male', 'Female'];
  final motherTongueOptions = ['Tamil', 'Telugu', 'Malayalam', 'Hindi', 'English', 'Kannada'];
  final languageOptions = [
    'Tamil', 'English', 'Hindi', 'Telugu', 'Malayalam',
    'Kannada', 'Bengali', 'Gujarati', 'Marathi', 'Other'
  ];

  // Tamil Nadu cities (sample list - you can add more)
  final tamilNaduCities = [
    'Chennai', 'Coimbatore', 'Madurai', 'Tiruchirappalli', 'Salem',
    'Tirunelveli', 'Erode', 'Vellore', 'Thoothukkudi', 'Dindigul',
    'Thanjavur', 'Hosur', 'Nagercoil', 'Kanchipuram', 'Kumarapalayam',
    'Karaikkudi', 'Neyveli', 'Cuddalore', 'Ambur', 'Pollachi',
    'Rajapalayam', 'Sivakasi', 'Pudukkottai', 'Vaniyambadi', 'Nagapattinam',
    'Gudiyatham', 'Dharmapuri', 'Kumbakonam', 'Tiruvannamalai', 'Palladam',
    'Arakkonam', 'Ariyalur', 'Coonoor', 'Dharapuram', 'Manapparai',
    'Mayiladuthurai', 'Mettur', 'Mettupalayam', 'Panruti', 'Pattukkottai',
    'Perambalur', 'Puliyankudi', 'Rasipuram', 'Sankari', 'Sathyamangalam',
    'Sivaganga', 'Thiruvarur', 'Udumalaipettai', 'Valparai', 'Vedaranyam',
    'Viluppuram', 'Virudhunagar'
  ];

  void _openBottomSheet({
    required String title,
    required List<String> options,
    required String? selectedValue,
    required Function(String?) onSelect,
    bool isMultiSelect = false,
    List<String>? multiSelectedValues,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
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
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              if (!isMultiSelect)
                Expanded(
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final option = options[index];
                      return RadioListTile(
                        title: Text(option),
                        value: option,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          onSelect(value);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                )
              else
                Expanded(
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final option = options[index];
                                return CheckboxListTile(
                                  title: Text(option),
                                  value: multiSelectedValues?.contains(option) ?? false,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == true) {
                                        multiSelectedValues?.add(option);
                                      } else {
                                        multiSelectedValues?.remove(option);
                                      }
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  onSelect(multiSelectedValues?.join(', '));
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Text(
                                  'Done',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _openMarital() {
    _openBottomSheet(
      title: 'Marital Status',
      options: maritalOptions,
      selectedValue: _marital,
      onSelect: (value) => setState(() => _marital = value),
    );
  }

  void _openGender() {
    _openBottomSheet(
      title: 'Gender',
      options: genderOptions,
      selectedValue: _gender,
      onSelect: (value) => setState(() => _gender = value),
    );
  }

  void _openCity() {
    _openBottomSheet(
      title: 'Current Location',
      options: tamilNaduCities,
      selectedValue: _city,
      onSelect: (value) => setState(() => _city = value),
    );
  }

  void _openMotherTongue() {
    _openBottomSheet(
      title: 'Mother Tongue',
      options: motherTongueOptions,
      selectedValue: _motherTongue,
      onSelect: (value) => setState(() => _motherTongue = value),
    );
  }

  void _openKnownLanguages() {
    _openBottomSheet(
      title: 'Known Languages',
      options: languageOptions,
      selectedValue: null,
      onSelect: (value) => setState(() {}),
      isMultiSelect: true,
      multiSelectedValues: _knownLanguages,
    );
  }

  void _gotoNext() {
    final details = {
      'name': _name.text.trim(),
      'dob': _dob.text.trim(),
      'height': _height.text.trim(),
      'gender': _gender,
      'marital': _marital,
      'city': _city,
      'motherTongue': _motherTongue,
      'knownLanguages': _knownLanguages,
    };
    BlocProvider.of<RegistrationBloc>(context).add(PersonalDetailsUpdated(details));
    Navigator.of(context).pushNamed(Routes.religion);
  }

  @override
  void dispose() {
    _name.dispose();
    _dob.dispose();
    _height.dispose();
    super.dispose();
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required VoidCallback onTap,
    bool showBorder = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSizes.fieldHeight,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: showBorder
              ? Border.all(color: const Color(0xFFE0E0E6))
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value ?? label,
              style: TextStyle(
                color: value != null ? Colors.black : Colors.grey,
                fontSize: 16,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              Text(
                "Let's begin with you! Tell us a bit about yourself.",
                style: AppTextStyles.heading(context),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _name,
                hint: 'Name',
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(1995, 1, 1),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    _dob.text = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
                  }
                },
                child: AbsorbPointer(
                  child: CustomTextField(
                    controller: _dob,
                    hint: 'Date of Birth',
                    prefixIcon: Icons.calendar_today_outlined,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _height,
                hint: 'Height (ft)',
                prefixIcon: Icons.height_outlined,
              ),
              const SizedBox(height: 12),
              _buildDropdownField(
                label: 'Gender',
                value: _gender,
                onTap: _openGender,
              ),
              const SizedBox(height: 12),
              _buildDropdownField(
                label: 'Marital status',
                value: _marital,
                onTap: _openMarital,
              ),
              const SizedBox(height: 12),
              _buildDropdownField(
                label: 'Current location',
                value: _city,
                onTap: _openCity,
              ),
              const SizedBox(height: 20),
              const Text(
                'Mother Tongue',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildDropdownField(
                label: 'Select mother tongue',
                value: _motherTongue,
                onTap: _openMotherTongue,
              ),
              const SizedBox(height: 20),
              const Text(
                'Known Languages',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _openKnownLanguages,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE0E0E6)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _knownLanguages.isNotEmpty
                            ? _knownLanguages.join(', ')
                            : 'Select known languages',
                        style: TextStyle(
                          color: _knownLanguages.isNotEmpty
                              ? Colors.black
                              : Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      if (_knownLanguages.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _knownLanguages
                              .map((lang) => Chip(
                            label: Text(lang),
                            backgroundColor: Colors.blue.shade50,
                            deleteIcon: const Icon(Icons.close, size: 16),
                            onDeleted: () {
                              setState(() {
                                _knownLanguages.remove(lang);
                              });
                            },
                          ))
                              .toList(),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              RoundedButton(
                label: 'Next',
                onPressed: _gotoNext,
                isEnabled: _name.text.isNotEmpty &&
                    _dob.text.isNotEmpty &&
                    _height.text.isNotEmpty &&
                    _gender != null &&
                    _marital != null &&
                    _city != null &&
                    _motherTongue != null &&
                    _knownLanguages.isNotEmpty,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}