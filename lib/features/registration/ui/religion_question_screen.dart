import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/alcohol_preference_page.dart';
import '../../../core/widgets/attendance_page.dart';
import '../../../core/widgets/career_approach_page.dart';
import '../../../core/widgets/dietary_preference_page.dart';
import '../../../core/widgets/education_background_page.dart';
import '../../../core/widgets/faith_journey_page.dart';
import '../../../core/widgets/future_partner_denomination_page.dart';
import '../../../core/widgets/involvement_page.dart';
import '../../../core/widgets/lifestyle_values_page.dart';
import '../../../core/widgets/ministry_calling_page.dart';
import '../../../core/widgets/relocation_preference_page.dart';
import '../../../core/widgets/rounded_button.dart';
import '../../../core/widgets/spend_time_page.dart';
import '../../../core/widgets/tradition_page.dart';
import '../../../core/widgets/work_location_page.dart';
import '../../../core/widgets/work_role_page.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';

class ReligionQuestionScreen extends StatefulWidget {
  const ReligionQuestionScreen({super.key});

  @override
  State<ReligionQuestionScreen> createState() => _ReligionQuestionScreenState();
}

class _ReligionQuestionScreenState extends State<ReligionQuestionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Single-selection fields
  String? _selectedTradition;
  String? _selectedAttendance;
  String? _selectedChurchActivities;
  String? _selectedFaithJourney;
  String? _selectedSpendTime;
  String? _selectedFuturePartnerDenomination;
  String? _selectedMinistryCalling;
  String? _selectedEducationBackground;
  String? _selectedWorkRole;
  String? _selectedCareerApproach;
  String? _selectedRelocationPreference;
  String? _selectedDietaryPreference;
  String? _selectedAlcoholPreference;

  // Work location dropdowns
  String? _selectedWorkCity;
  String? _selectedWorkCountry;

  // Multi-select lifestyle
  List<String> _selectedLifestyleValues = [];

  // Helpers
  int get _pageCount => _pages.length;
  late final List<Widget> _pages = [
    TraditionPage(
      selectedValue: _selectedTradition,
      onSelected: (v) => setState(() => _selectedTradition = v),
    ),
    AttendancePage(
      selectedValue: _selectedAttendance,
      onSelected: (v) => setState(() => _selectedAttendance = v),
    ),
    InvolvementPage(
      selectedValue: _selectedChurchActivities,
      onSelected: (v) => setState(() => _selectedChurchActivities = v),
    ),
    FaithJourneyPage(
      selectedValue: _selectedFaithJourney,
      onSelected: (v) => setState(() => _selectedFaithJourney = v),
    ),
    SpendTimePage(
      selectedValue: _selectedSpendTime,
      onSelected: (v) => setState(() => _selectedSpendTime = v),
    ),
    FuturePartnerDenominationPage(
      selectedValue: _selectedFuturePartnerDenomination,
      onSelected: (v) => setState(() => _selectedFuturePartnerDenomination = v),
    ),
    MinistryCallingPage(
      selectedValue: _selectedMinistryCalling,
      onSelected: (v) => setState(() => _selectedMinistryCalling = v),
    ),
    EducationBackgroundPage(
      selectedValue: _selectedEducationBackground,
      onSelected: (v) => setState(() => _selectedEducationBackground = v),
    ),
    WorkRolePage(
      selectedValue: _selectedWorkRole,
      onSelected: (v) => setState(() => _selectedWorkRole = v),
    ),
    WorkLocationPage(
      selectedCity: _selectedWorkCity,
      selectedCountry: _selectedWorkCountry,
      onCitySelected: (v) => setState(() => _selectedWorkCity = v),
      onCountrySelected: (v) => setState(() => _selectedWorkCountry = v),
    ),
    CareerApproachPage(
      selectedValue: _selectedCareerApproach,
      onSelected: (v) => setState(() => _selectedCareerApproach = v),
    ),
    RelocationPreferencePage(
      selectedValue: _selectedRelocationPreference,
      onSelected: (v) => setState(() => _selectedRelocationPreference = v),
    ),
    DietaryPreferencePage(
      selectedValue: _selectedDietaryPreference,
      onSelected: (v) => setState(() => _selectedDietaryPreference = v),
    ),
    AlcoholPreferencePage(
      selectedValue: _selectedAlcoholPreference,
      onSelected: (v) => setState(() => _selectedAlcoholPreference = v),
    ),
    LifestyleValuesPage(
      selectedValues: _selectedLifestyleValues,
      onSelectionChanged: (list) =>
          setState(() => _selectedLifestyleValues = list),
    ),
  ];

  // Navigate to next page or submit when last
  void _handleNext() {
    final lastIndex = _pageCount - 1;
    if (_currentPage < lastIndex) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    // Collect answers
    final answers = {
      'tradition': _selectedTradition,
      'attendance': _selectedAttendance,
      'involved': _selectedChurchActivities,
      'faithJourney': _selectedFaithJourney,
      'spendTime': _selectedSpendTime,
      'futurePartnerDenomination': _selectedFuturePartnerDenomination,
      'ministryCalling': _selectedMinistryCalling,
      'educationBackground': _selectedEducationBackground,
      'workRole': _selectedWorkRole,
      'workCity': _selectedWorkCity,
      'workCountry': _selectedWorkCountry,
      'careerApproach': _selectedCareerApproach,
      'relocationPreference': _selectedRelocationPreference,
      'dietaryPreference': _selectedDietaryPreference,
      'alcoholPreference': _selectedAlcoholPreference,
      'lifestyleValues': _selectedLifestyleValues,
    };

    BlocProvider.of<RegistrationBloc>(
      context,
    ).add(ReligionAnswerUpdated(answers));
    BlocProvider.of<RegistrationBloc>(context).add(SubmitRegistration());
  }

  bool _isNextEnabled() {
    // Validate the current page's required selection(s)
    switch (_currentPage) {
      case 0:
        return _selectedTradition != null;
      case 1:
        return _selectedAttendance != null;
      case 2:
        return _selectedChurchActivities != null;
      case 3:
        return _selectedFaithJourney != null;
      case 4:
        return _selectedSpendTime != null;
      case 5:
        return _selectedFuturePartnerDenomination != null;
      case 6:
        return _selectedMinistryCalling != null;
      case 7:
        return _selectedEducationBackground != null;
      case 8:
        return _selectedWorkRole != null;
      case 9:
        // work location requires city & country selected
        return _selectedWorkCity != null && _selectedWorkCountry != null;
      case 10:
        return _selectedCareerApproach != null;
      case 11:
        return _selectedRelocationPreference != null;
      case 12:
        return _selectedDietaryPreference != null;
      case 13:
        return _selectedAlcoholPreference != null;
      case 14:
        // lifestyle values page: allow empty or require at least one? design didn't force — we'll require at least 0 selectable (allow next even if empty)
        // If you want to require at least one selection, change to: return _selectedLifestyleValues.isNotEmpty;
        return true;
      default:
        return true;
    }
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          width: 120,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: _currentPage == index ? AppColors.primary : AppColors.border,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Because _pages uses state variables in constructors, rebuild the list on each build
    // to ensure widgets receive updated values / callbacks.
    final pages = [
      TraditionPage(
        selectedValue: _selectedTradition,
        onSelected: (v) => setState(() => _selectedTradition = v),
      ),
      AttendancePage(
        selectedValue: _selectedAttendance,
        onSelected: (v) => setState(() => _selectedAttendance = v),
      ),
      InvolvementPage(
        selectedValue: _selectedChurchActivities,
        onSelected: (v) => setState(() => _selectedChurchActivities = v),
      ),
      FaithJourneyPage(
        selectedValue: _selectedFaithJourney,
        onSelected: (v) => setState(() => _selectedFaithJourney = v),
      ),
      SpendTimePage(
        selectedValue: _selectedSpendTime,
        onSelected: (v) => setState(() => _selectedSpendTime = v),
      ),
      FuturePartnerDenominationPage(
        selectedValue: _selectedFuturePartnerDenomination,
        onSelected: (v) =>
            setState(() => _selectedFuturePartnerDenomination = v),
      ),
      MinistryCallingPage(
        selectedValue: _selectedMinistryCalling,
        onSelected: (v) => setState(() => _selectedMinistryCalling = v),
      ),
      EducationBackgroundPage(
        selectedValue: _selectedEducationBackground,
        onSelected: (v) => setState(() => _selectedEducationBackground = v),
      ),
      WorkRolePage(
        selectedValue: _selectedWorkRole,
        onSelected: (v) => setState(() => _selectedWorkRole = v),
      ),
      WorkLocationPage(
        selectedCity: _selectedWorkCity,
        selectedCountry: _selectedWorkCountry,
        onCitySelected: (v) => setState(() => _selectedWorkCity = v),
        onCountrySelected: (v) => setState(() => _selectedWorkCountry = v),
      ),
      CareerApproachPage(
        selectedValue: _selectedCareerApproach,
        onSelected: (v) => setState(() => _selectedCareerApproach = v),
      ),
      RelocationPreferencePage(
        selectedValue: _selectedRelocationPreference,
        onSelected: (v) => setState(() => _selectedRelocationPreference = v),
      ),
      DietaryPreferencePage(
        selectedValue: _selectedDietaryPreference,
        onSelected: (v) => setState(() => _selectedDietaryPreference = v),
      ),
      AlcoholPreferencePage(
        selectedValue: _selectedAlcoholPreference,
        onSelected: (v) => setState(() => _selectedAlcoholPreference = v),
      ),
      LifestyleValuesPage(
        selectedValues: _selectedLifestyleValues,
        onSelectionChanged: (list) =>
            setState(() => _selectedLifestyleValues = list),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 80,
        leading: Container(
          margin: const EdgeInsets.only(left: 8, top: 6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: IconButton(
            icon: SvgPicture.asset(AppAssets.arrowRight),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          // Optional Skip action shown in designs
          TextButton(
            onPressed: () {
              // If you want Skip to jump to end / submit, implement here.
              // For now it simply advances to next page.
              final lastIndex = pages.length - 1;
              if (_currentPage < lastIndex) {
                _pageController.animateToPage(
                  _currentPage + 1,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: const Text('Skip', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSizes.screenTopSpacing),
            _buildPageIndicator(),
            const SizedBox(height: AppSizes.largeSpacing),

            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: pages,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding,
                vertical: AppSizes.verticalPadding,
              ),
              child: RoundedButton(
                label: AppStrings.next,
                onPressed: _isNextEnabled() ? _handleNext : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
