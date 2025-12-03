import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/widgets/rounded_button.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/radio_list_item.dart';
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

  String? _selectedTradition;
  String? _selectedAttendance;
  bool _isInvolved = false;

  final List<String> _traditions = [
    'Roman Catholic',
    'Protestant (Pentecostal/Evangelical)',
    'Orthodox (Syrian/Jacobite/Mar Thoma)',
    'Methodist',
    'Lutheran',
    'Baptist',
    'Presbyterian',
    'Independent/Non-denominational',
    'Still exploring different traditions',
  ];

  final List<String> _attendanceOptions = [
    'Weekly (almost every Sunday)',
    'Biweekly (2-3 times a month)',
    'Monthly (once a month)',
    'Occasionally (festivals & special occasions)',
    'Rarely',
  ];

  List<Widget> _buildQuestionPages() {
    return [
      // Page 1: Tradition question
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Which Christian tradition feels most like home to you?',
              style: AppTextStyles.heading(context),
            ),
            const SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _traditions.length,
              separatorBuilder: (context, index) => const Divider(
                height: 0,
                color: AppColors.border,
              ),
              itemBuilder: (context, index) {
                final tradition = _traditions[index];
                return RadioListItem<String>(
                  value: tradition,
                  groupValue: _selectedTradition,
                  label: tradition,
                  onChanged: (value) {
                    setState(() {
                      _selectedTradition = value;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),

      // Page 2: Attendance question
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How often do you attend church services?',
              style: AppTextStyles.heading(context),
            ),
            const SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _attendanceOptions.length,
              separatorBuilder: (context, index) => const Divider(
                height: 0,
                color: AppColors.border,
              ),
              itemBuilder: (context, index) {
                final attendance = _attendanceOptions[index];
                return RadioListItem<String>(
                  value: attendance,
                  groupValue: _selectedAttendance,
                  label: attendance,
                  onChanged: (value) {
                    setState(() {
                      _selectedAttendance = value;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),

      // Page 3: Involvement question
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you involved in any church activities or ministries?',
              style: AppTextStyles.heading(context),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SwitchListTile(
                value: _isInvolved,
                onChanged: (value) => setState(() => _isInvolved = value),
                title: Text(
                  'Yes, I am involved',
                  style: AppTextStyles.body(context),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  String _getButtonText() {
    if (_currentPage == 2) return 'Submit';
    return 'Next';
  }

  void _handleButtonPress() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Submit all answers
      final answers = {
        'tradition': _selectedTradition,
        'attendance': _selectedAttendance,
        'involved': _isInvolved,
      };
      BlocProvider.of<RegistrationBloc>(context).add(ReligionAnswerUpdated(answers));
      BlocProvider.of<RegistrationBloc>(context).add(SubmitRegistration());

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Registration completed'),
          content: const Text('This is a dummy flow. Replace repository with real API to persist.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  bool _isButtonEnabled() {
    switch (_currentPage) {
      case 0:
        return _selectedTradition != null;
      case 1:
        return _selectedAttendance != null;
      case 2:
        return true; // Switch is optional
      default:
        return false;
    }
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          width: 120,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: _currentPage == index ? AppColors.primary : AppColors.border,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 80,
        leading: Container(
          margin: const EdgeInsets.only(
            left: 8.0,
            top: 6.0,
            bottom: 0.0,
            right: 6.0,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border, width: 1.0),
          ),
          child: IconButton(
            icon: SvgPicture.asset(AppAssets.arrowRight),
            onPressed: () => Navigator.of(context).pop(),
            padding: const EdgeInsets.all(8.0),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSizes.screenTopSpacing),
            _buildPageIndicator(),
            const SizedBox(height: 24),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: _buildQuestionPages(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding,
                vertical: AppSizes.verticalPadding,
              ),
              child: RoundedButton(
                label: _getButtonText(),
                onPressed: _isButtonEnabled() ? _handleButtonPress : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
