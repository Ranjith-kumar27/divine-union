import 'package:divineunion_matrimony/core/widgets/question-tab2/joy_life_page_two.dart';
import 'package:divineunion_matrimony/features/registration/ui/registration_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/question-tab1/alcohol_preference_page.dart';
import '../../../core/widgets/question-tab1/attendance_page.dart';
import '../../../core/widgets/question-tab1/career_approach_page.dart';
import '../../../core/widgets/question-tab1/conflict_handling_page.dart';
import '../../../core/widgets/question-tab1/dietary_preference_page.dart';
import '../../../core/widgets/question-tab1/education_background_page.dart';
import '../../../core/widgets/question-tab1/faith_journey_page.dart';
import '../../../core/widgets/question-tab1/family_setup_page.dart';
import '../../../core/widgets/question-tab1/future_partner_denomination_page.dart';
import '../../../core/widgets/question-tab1/involvement_page.dart';
import '../../../core/widgets/question-tab1/lifestyle_values_page.dart';
import '../../../core/widgets/question-tab1/ministry_calling_page.dart';
import '../../../core/widgets/question-tab1/peaceful_evening_page.dart';
import '../../../core/widgets/question-tab1/relocation_preference_page.dart';
import '../../../core/widgets/question-tab1/spend_time_page.dart';
import '../../../core/widgets/question-tab1/tradition_page.dart';
import '../../../core/widgets/question-tab1/weekends_page.dart';
import '../../../core/widgets/question-tab1/work_location_page.dart';
import '../../../core/widgets/question-tab1/work_role_page.dart';
import '../../../core/widgets/question-tab2/children_count_page.dart';
import '../../../core/widgets/question-tab2/children_desire_page.dart';
import '../../../core/widgets/question-tab2/christ_centered_life_page.dart';
import '../../../core/widgets/question-tab2/differences_in_partner_page.dart';
import '../../../core/widgets/question-tab2/difficult_to_accept_page.dart';
import '../../../core/widgets/question-tab2/family_approval_page.dart';
import '../../../core/widgets/question-tab2/family_dynamic_page.dart';
import '../../../core/widgets/question-tab2/family_involvement_page.dart';
import '../../../core/widgets/question-tab2/joy_life_page_one.dart';
import '../../../core/widgets/question-tab2/life_partner_values_page.dart';
import '../../../core/widgets/question-tab2/married_life_vision_page.dart';
import '../../../core/widgets/question-tab2/parents_work_page.dart';
import '../../../core/widgets/question-tab2/partner_age_range_page.dart';
import '../../../core/widgets/question-tab2/partner_height_page.dart';
import '../../../core/widgets/question-tab2/siblings_page.dart';
import '../../../core/widgets/question-tab3/future_partner_message_page.dart';
import '../../../core/widgets/question-tab3/hope_for_partner_page.dart';
import '../../../core/widgets/question-tab3/journey_meaning_page.dart';
import '../../../core/widgets/rounded_button.dart';
import '../../../routes.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';
import '../bloc/registration_state.dart'; // Add this import

class ReligionQuestionScreen extends StatefulWidget {
  const ReligionQuestionScreen({super.key});

  @override
  State<ReligionQuestionScreen> createState() => _ReligionQuestionScreenState();
}

class _ReligionQuestionScreenState extends State<ReligionQuestionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  /// TAB1 values
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
  String? _selectedWorkCity;
  String? _selectedWorkCountry;
  List<String> _selectedLifestyleValues = [];
  String? _selectedConflict;
  String? _selectedWeekend;
  String? _selectedEvening;
  String? _selectedFamilySetup;

  /// TAB2 values
  String? _siblingType;
  int _marriedCount = 0;
  int _unmarriedCount = 0;
  String _fatherOcc = "";
  String _motherOcc = "";
  String? _familyApproval;
  String? _familyDynamic;
  String? _familyInvolvement;
  List<String> _selectedJoyOneItems = [];
  List<String> _selectedJoyTwoItems = [];
  String? _selectedDifferencesInPartner;
  List<String> _selectedDifficultToAccept = [];
  List<String> _selectedLifePartnerValues = [];
  List<String> _selectedChristCenteredLife = [];
  String? _partnerAgeRange;
  String? _partnerHeight;
  List<String> _marriedLifeVision = [];
  String? _childrenDesire;
  String? _childrenCount;

  /// TAB3 values
  String? _journeyMeaning;
  String _futurePartnerMessage = "";
  String? _hopeForPartner;

  /// TOTAL PAGES UPDATED - Now includes Tab3 pages
  final int totalPages = 38; // 0–37 (Tab1: 0-18, Tab2: 19-34, Tab3: 35-37)

  // ============== BACK =================
  void _handleBack() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  // ============== NEXT =================
  void _handleNext() {
    if (_currentPage < totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    // On last page, submit the registration
    _submitRegistration();
  }

  // ============== SUBMIT =================
  void _submitRegistration() {
    final answers = {
      /// TAB1
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
      'conflictHandling': _selectedConflict,
      'weekendStyle': _selectedWeekend,
      'peacefulEvening': _selectedEvening,
      'familySetup': _selectedFamilySetup,

      /// TAB2
      'siblingType': _siblingType,
      'marriedCount': _marriedCount,
      'unmarriedCount': _unmarriedCount,
      'fatherOccupation': _fatherOcc,
      'motherOccupation': _motherOcc,
      'familyApprovalImportance': _familyApproval,
      'familyDynamicExpectation': _familyDynamic,
      'familyDecisionInvolvement': _familyInvolvement,
      'joyInLifeOne': _selectedJoyOneItems,
      'joyInLifeTwo': _selectedJoyTwoItems,
      'differencesInPartner': _selectedDifferencesInPartner,
      'difficultToAccept': _selectedDifficultToAccept,
      'lifePartnerValues': _selectedLifePartnerValues,
      'christCenteredLife': _selectedChristCenteredLife,
      'partnerAgeRange': _partnerAgeRange,
      'partnerHeight': _partnerHeight,
      'marriedLifeVision': _marriedLifeVision,
      'childrenDesire': _childrenDesire,
      'childrenCount': _childrenCount,

      /// TAB3
      'journeyMeaning': _journeyMeaning,
      'futurePartnerMessage': _futurePartnerMessage,
      'hopeForPartner': _hopeForPartner,
    };

    BlocProvider.of<RegistrationBloc>(
      context,
    ).add(ReligionAnswerUpdated(answers));
    BlocProvider.of<RegistrationBloc>(context).add(SubmitRegistration());
  }

  // ========== Button Text ==========
  String _getButtonText() {
    return _currentPage == totalPages - 1 ? "Submit" : "Next";
  }

  // ========== Helper methods for progress ==========
  int _getCurrentStep() {
    if (_currentPage <= 18) return 1;
    if (_currentPage <= 34) return 2;
    return 3;
  }

  int _getStepQuestionNumber() {
    if (_currentPage <= 18) return _currentPage + 1;
    if (_currentPage <= 34) return _currentPage - 18;
    return _currentPage - 34;
  }

  int _getStepTotalQuestions() {
    if (_currentPage <= 18) return 19;
    if (_currentPage <= 34) return 16;
    return 3;
  }

  int _getOverallProgressPercentage() {
    return ((_currentPage) / totalPages * 100).round();
  }

  // ========== Next Button Validation ==========
  bool _isNextEnabled() {
    switch (_currentPage) {
      case 0:
        return _selectedTradition != null;
      case 1:
        return _selectedAttendance != null;
      // ... (rest of the cases)
      case 37:
        return _hopeForPartner != null;

      default:
        return true;
    }
  }

  // =============== UI ===============
  @override
  Widget build(BuildContext context) {
    final currentStep = _getCurrentStep();
    final stepQuestionNum = _getStepQuestionNumber();
    final stepTotalQuestions = _getStepTotalQuestions();
    final overallProgressPercent = _getOverallProgressPercentage();

    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        // Listen for success state to navigate
        if (state.status == RegistrationStatus.success) {
          // Navigate to success screen after successful submission
          _navigateToSuccessScreen(context);
        }
      },
      child: PopScope(
        canPop: _currentPage == 0, // Only allow popping when on first page
        onPopInvoked: (didPop) {
          if (!didPop) {
            _handleBack();
          }
        },
        child: Scaffold(
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
              // Only show Skip button if not on last page
              if (_currentPage < totalPages - 1)
                TextButton(
                  onPressed: () {
                    if (_currentPage < totalPages - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
            ],
          ),

          body: Column(
            children: [
              /// 3 TAB INDICATOR (Updated to show Tab3 progress)
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 110,
                      height: 5,
                      decoration: BoxDecoration(
                        color: currentStep >= 1
                            ? AppColors.primary
                            : AppColors.border,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 8),

                    Container(
                      width: 110,
                      height: 5,
                      decoration: BoxDecoration(
                        color: currentStep >= 2
                            ? AppColors.primary
                            : AppColors.border,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 8),

                    Container(
                      width: 110,
                      height: 5,
                      decoration: BoxDecoration(
                        color: currentStep >= 3
                            ? AppColors.primary
                            : AppColors.border,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Step $currentStep of 3",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      "$stepQuestionNum/$stepTotalQuestions",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (i) => setState(() => _currentPage = i),

                  children: [
                    /// TAB1 screens (0–18)
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
                    ConflictHandlingPage(
                      selectedValue: _selectedConflict,
                      onSelected: (v) => setState(() => _selectedConflict = v),
                    ),
                    WeekendsPage(
                      selectedValue: _selectedWeekend,
                      onSelected: (v) => setState(() => _selectedWeekend = v),
                    ),
                    PeacefulEveningPage(
                      selectedValue: _selectedEvening,
                      onSelected: (v) => setState(() => _selectedEvening = v),
                    ),
                    FamilySetupPage(
                      selectedValue: _selectedFamilySetup,
                      onSelected: (v) =>
                          setState(() => _selectedFamilySetup = v),
                    ),

                    /// TAB2 screens (19–34)
                    ParentsWorkPage(
                      fatherOccupation: _fatherOcc,
                      motherOccupation: _motherOcc,
                      onChanged: (f, m) {
                        setState(() {
                          _fatherOcc = f;
                          _motherOcc = m;
                        });
                      },
                    ),

                    SiblingsPage(
                      selectedValue: _siblingType,
                      marriedCount: _marriedCount,
                      unmarriedCount: _unmarriedCount,
                      onSelected: (v) => setState(() => _siblingType = v),
                      onSiblingCountChanged: (m, u) {
                        setState(() {
                          _marriedCount = m;
                          _unmarriedCount = u;
                        });
                      },
                    ),

                    FamilyApprovalImportancePage(
                      selectedValue: _familyApproval,
                      onSelected: (v) => setState(() => _familyApproval = v),
                    ),

                    FamilyDynamicPage(
                      selectedValue: _familyDynamic,
                      onSelected: (v) => setState(() => _familyDynamic = v),
                    ),

                    FamilyInvolvementPage(
                      selectedValue: _familyInvolvement,
                      onSelected: (v) => setState(() => _familyInvolvement = v),
                    ),

                    JoyInLifePageOne(
                      selectedItems: _selectedJoyOneItems,
                      onSelectionChanged: (items) {
                        setState(() {
                          _selectedJoyOneItems = items;
                        });
                      },
                    ),

                    JoyInLifePageTwo(
                      selectedItems: _selectedJoyTwoItems,
                      onSelectionChanged: (items) {
                        setState(() {
                          _selectedJoyTwoItems = items;
                        });
                      },
                    ),

                    ChristCenteredLifePage(
                      selectedItems: _selectedChristCenteredLife,
                      onSelectionChanged: (items) {
                        setState(() {
                          _selectedChristCenteredLife = items;
                        });
                      },
                    ),

                    LifePartnerValuesPage(
                      selectedItems: _selectedLifePartnerValues,
                      onSelectionChanged: (items) {
                        setState(() {
                          _selectedLifePartnerValues = items;
                        });
                      },
                    ),

                    DifferencesInPartnerPage(
                      selectedValue: _selectedDifferencesInPartner,
                      onSelectionChanged: (value) {
                        setState(() {
                          _selectedDifferencesInPartner = value;
                        });
                      },
                    ),

                    DifficultToAcceptPage(
                      selectedItems: _selectedDifficultToAccept,
                      onSelectionChanged: (items) {
                        setState(() {
                          _selectedDifficultToAccept = items;
                        });
                      },
                    ),

                    PartnerAgeRangePage(
                      selectedValue: _partnerAgeRange,
                      onSelected: (v) => setState(() => _partnerAgeRange = v),
                    ),

                    PartnerHeightPage(
                      selectedValue: _partnerHeight,
                      onSelected: (v) => setState(() => _partnerHeight = v),
                    ),

                    MarriedLifeVisionPage(
                      selectedItems: _marriedLifeVision,
                      onSelectionChanged: (items) {
                        setState(() => _marriedLifeVision = items);
                      },
                    ),

                    ChildrenDesirePage(
                      selectedValue: _childrenDesire,
                      onSelected: (v) => setState(() => _childrenDesire = v),
                    ),

                    ChildrenCountPage(
                      selectedValue: _childrenCount,
                      onSelected: (v) => setState(() => _childrenCount = v),
                    ),

                    /// TAB3 screens (35–37)
                    JourneyMeaningPage(
                      selectedValue: _journeyMeaning,
                      onSelected: (value) {
                        setState(() => _journeyMeaning = value);
                      },
                    ),

                    FuturePartnerMessagePage(
                      initialMessage: _futurePartnerMessage,
                      onChanged: (message) {
                        setState(() => _futurePartnerMessage = message);
                      },
                    ),

                    HopeForPartnerPage(
                      selectedValue: _hopeForPartner,
                      onSelected: (value) {
                        setState(() => _hopeForPartner = value);
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(22, 12, 22, 12),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: RoundedButton(
                        label: _getButtonText(),
                        onPressed: _isNextEnabled() ? _handleNext : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "${_currentPage + 1} of $totalPages questions • $overallProgressPercent% complete",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // ============== NAVIGATE TO SUCCESS SCREEN =================
  void _navigateToSuccessScreen(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.registrationSuccess,
      (route) => false, // Clear all routes
    );
  }
}
