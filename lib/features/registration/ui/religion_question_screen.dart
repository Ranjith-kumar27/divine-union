import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/question-tab1/alcohol_preference_page.dart';
import '../../../core/widgets/question-tab1/attendance_page.dart';
import '../../../core/widgets/question-tab1/career_approach_page.dart';
import '../../../core/widgets/question-tab1/dietary_preference_page.dart';
import '../../../core/widgets/question-tab1/education_background_page.dart';
import '../../../core/widgets/question-tab1/faith_journey_page.dart';
import '../../../core/widgets/question-tab1/future_partner_denomination_page.dart';
import '../../../core/widgets/question-tab1/involvement_page.dart';
import '../../../core/widgets/question-tab1/lifestyle_values_page.dart';
import '../../../core/widgets/question-tab1/ministry_calling_page.dart';
import '../../../core/widgets/question-tab1/relocation_preference_page.dart';
import '../../../core/widgets/question-tab1/spend_time_page.dart';
import '../../../core/widgets/question-tab1/tradition_page.dart';
import '../../../core/widgets/question-tab1/work_location_page.dart';
import '../../../core/widgets/question-tab1/work_role_page.dart';
import '../../../core/widgets/rounded_button.dart';
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

  // Helper methods
  void _handleBack() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // If we're on the first page, close the entire screen
      Navigator.pop(context);
    }
  }

  void _handleNext() {
    final lastIndex = 15; // There are 15 pages (0-14)
    if (_currentPage < lastIndex - 1) {
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
        // lifestyle values page: allow empty
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 55,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12, top: 12),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: IconButton(
              icon: SvgPicture.asset(AppAssets.arrowRight),
              onPressed: _handleBack,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_currentPage < 14) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: const Text(
              'Skip',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            /// ---------- Page Indicator ----------
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Container(
                    width: 110,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: _currentPage ~/ 5 == index
                          ? AppColors.primary
                          : AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),

            /// ---------- Pages ----------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  children: [
                    TraditionPage(
                      selectedValue: _selectedTradition,
                      onSelected: (v) => setState(() => _selectedTradition = v),
                    ),
                    AttendancePage(
                      selectedValue: _selectedAttendance,
                      onSelected: (v) =>
                          setState(() => _selectedAttendance = v),
                    ),
                    InvolvementPage(
                      selectedValue: _selectedChurchActivities,
                      onSelected: (v) =>
                          setState(() => _selectedChurchActivities = v),
                    ),
                    FaithJourneyPage(
                      selectedValue: _selectedFaithJourney,
                      onSelected: (v) =>
                          setState(() => _selectedFaithJourney = v),
                    ),
                    SpendTimePage(
                      selectedValue: _selectedSpendTime,
                      onSelected: (v) => setState(() => _selectedSpendTime = v),
                    ),
                    FuturePartnerDenominationPage(
                      selectedValue: _selectedFuturePartnerDenomination,
                      onSelected: (v) => setState(
                        () => _selectedFuturePartnerDenomination = v,
                      ),
                    ),
                    MinistryCallingPage(
                      selectedValue: _selectedMinistryCalling,
                      onSelected: (v) =>
                          setState(() => _selectedMinistryCalling = v),
                    ),
                    EducationBackgroundPage(
                      selectedValue: _selectedEducationBackground,
                      onSelected: (v) =>
                          setState(() => _selectedEducationBackground = v),
                    ),
                    WorkRolePage(
                      selectedValue: _selectedWorkRole,
                      onSelected: (v) => setState(() => _selectedWorkRole = v),
                    ),
                    WorkLocationPage(
                      selectedCity: _selectedWorkCity,
                      selectedCountry: _selectedWorkCountry,
                      onCitySelected: (v) =>
                          setState(() => _selectedWorkCity = v),
                      onCountrySelected: (v) =>
                          setState(() => _selectedWorkCountry = v),
                    ),
                    CareerApproachPage(
                      selectedValue: _selectedCareerApproach,
                      onSelected: (v) =>
                          setState(() => _selectedCareerApproach = v),
                    ),
                    RelocationPreferencePage(
                      selectedValue: _selectedRelocationPreference,
                      onSelected: (v) =>
                          setState(() => _selectedRelocationPreference = v),
                    ),
                    DietaryPreferencePage(
                      selectedValue: _selectedDietaryPreference,
                      onSelected: (v) =>
                          setState(() => _selectedDietaryPreference = v),
                    ),
                    AlcoholPreferencePage(
                      selectedValue: _selectedAlcoholPreference,
                      onSelected: (v) =>
                          setState(() => _selectedAlcoholPreference = v),
                    ),
                    LifestyleValuesPage(
                      selectedValues: _selectedLifestyleValues,
                      onSelectionChanged: (v) =>
                          setState(() => _selectedLifestyleValues = v),
                    ),
                  ],
                ),
              ),
            ),

            /// ---------- Bottom Next Button ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 22),
              child: SizedBox(
                width: double.infinity,
                child: RoundedButton(
                  label: AppStrings.next,
                  onPressed: _isNextEnabled() ? _handleNext : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
