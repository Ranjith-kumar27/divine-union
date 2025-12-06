import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';

class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({super.key});

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final TextEditingController _mobileCtrl = TextEditingController();
  bool _valid = false;
  bool _isFocused = false;

  void _onChange() {
    final t = _mobileCtrl.text.replaceAll(RegExp(r'\s+'), '');
    final ok = RegExp(r'^[6-9]\d{9}$').hasMatch(t);
    setState(() {
      _valid = ok;
    });
  }

  @override
  void initState() {
    super.initState();
    _mobileCtrl.addListener(_onChange);
  }

  @override
  void dispose() {
    _mobileCtrl.removeListener(_onChange);
    _mobileCtrl.dispose();
    super.dispose();
  }

  void _sendCode() {
    final mobile = _mobileCtrl.text.trim();
    BlocProvider.of<RegistrationBloc>(context).add(MobileSubmitted(mobile));
    Navigator.of(context).pushNamed(Routes.otp, arguments: mobile);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              // Main heading - Using Lora
              Text(
                AppStrings.journeyStartsHere,
                style: AppTextStyles.heading(context),
              ),
              SizedBox(height: screenHeight * 0.03),
              // "Your mobile number" label - Using Inter Medium
              Text(
                AppStrings.yourMobileNumber,
                style: AppTextStyles.label(
                  context,
                ).copyWith(color: AppColors.textPrimary),
              ),
              SizedBox(height: screenHeight * 0.01),
              // Phone number input field
              Container(
                height: screenHeight * 0.06,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isFocused ? AppColors.primary : AppColors.border,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    SizedBox(width: screenHeight * 0.02),
                    // Country code
                    Text(
                      AppStrings.countryCode,
                      style: AppTextStyles.bold(context).copyWith(
                        color: _mobileCtrl.text.isNotEmpty
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: screenHeight * 0.02),
                    // Vertical divider
                    Container(
                      width: 1,
                      height: screenHeight * 0.03,
                      color: AppColors.border,
                    ),
                    SizedBox(width: screenHeight * 0.02),
                    // Phone number input
                    Expanded(
                      child: Focus(
                        onFocusChange: (focus) {
                          setState(() {
                            _isFocused = focus;
                          });
                        },
                        child: TextField(
                          controller: _mobileCtrl,
                          keyboardType: TextInputType.phone,
                          style: AppTextStyles.bold(
                            context,
                          ).copyWith(color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            // hintText: AppStrings.enterMobileNumber,
                            hintStyle: AppTextStyles.bold(context),
                            counterText: '',
                          ),
                          maxLength: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Send Code Button - Using Inter SemiBold
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: _valid ? _sendCode : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _valid
                        ? AppColors.primary
                        : AppColors.disabled,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    disabledBackgroundColor: AppColors.disabled,
                    disabledForegroundColor: AppColors.textSecondary,
                  ),
                  child: Text(
                    AppStrings.sendCode,
                    style: AppTextStyles.buttonLabel(context),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
