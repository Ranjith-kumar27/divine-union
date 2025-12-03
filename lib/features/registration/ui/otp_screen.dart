import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/otp_widgets.dart';
import '../../../routes.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late String mobile;
  final List<TextEditingController> _otpControllers = [];
  final List<FocusNode> _focusNodes = [];
  bool _canVerify = false;
  int _remainingSeconds = 30;
  late Timer _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mobile = ModalRoute.of(context)?.settings.arguments as String? ?? '';
  }

  @override
  void initState() {
    super.initState();
    _initializeOtpFields();
    _startTimer();
  }

  void _initializeOtpFields() {
    for (int i = 0; i < 6; i++) {
      _otpControllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }

    for (var controller in _otpControllers) {
      controller.addListener(_updateVerificationState);
    }
  }

  void _startTimer() {
    _remainingSeconds = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  void _updateVerificationState() {
    final allFilled = _otpControllers.every(
      (controller) => controller.text.isNotEmpty,
    );
    if (_canVerify != allFilled) {
      setState(() => _canVerify = allFilled);
    }
  }

  void _handleOtpInput(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _onKeypadPressed(String value) {
    final emptyIndex = _otpControllers.indexWhere(
      (controller) => controller.text.isEmpty,
    );

    if (emptyIndex != -1) {
      _otpControllers[emptyIndex].text = value;
      if (emptyIndex < 5) {
        FocusScope.of(context).requestFocus(_focusNodes[emptyIndex + 1]);
      }
    }
  }

  void _onBackspacePressed() {
    final lastFilledIndex = _otpControllers.lastIndexWhere(
      (controller) => controller.text.isNotEmpty,
    );

    if (lastFilledIndex != -1) {
      _otpControllers[lastFilledIndex].text = '';
      if (lastFilledIndex > 0) {
        FocusScope.of(context).requestFocus(_focusNodes[lastFilledIndex - 1]);
      }
    }
  }

  void _verify() {
    final otp = _otpControllers.map((c) => c.text).join();
    BlocProvider.of<RegistrationBloc>(context).add(OtpSubmitted(mobile, otp));
    Navigator.of(context).pushReplacementNamed(Routes.profileType);
  }

  void _resendCode() {
    if (_remainingSeconds == 0) {
      _startTimer();
      // TODO: Implement resend OTP API call
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.04),
                      Text(
                        AppStrings.verifyContinue,
                        style: AppTextStyles.heading(context),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        AppStrings.otpDescription,
                        style: AppTextStyles.body(context),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      // Using extracted OTP widget
                      OtpFieldRow(
                        controllers: _otpControllers,
                        focusNodes: _focusNodes,
                        onFieldChangedWithIndex: (index) {
                          final value = _otpControllers[index].text;
                          _handleOtpInput(value, index);
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Add left padding to the timer
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 18.0),
                      //   // Adjust as needed
                      //   child: OtpTimerWidget(
                      //     remainingSeconds: _remainingSeconds,
                      //     onResend: _resendCode,
                      //     canResend: _remainingSeconds == 0,
                      //   ),
                      // ),
                      OtpTimerWidget(
                        remainingSeconds: _remainingSeconds,
                        onResend: _resendCode,
                        canResend: _remainingSeconds == 0,
                      ),
                      SizedBox(height: screenHeight * 0.06),
                    ],
                  ),
                ),
              ),
            ),
            // Verify button section
            _buildVerifyButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding,
        vertical: AppSizes.verticalPadding,
      ),
      child: SizedBox(
        width: double.infinity,
        height: screenHeight * 0.06,
        child: ElevatedButton(
          onPressed: _canVerify ? _verify : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _canVerify
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
            AppStrings.verifyCode,
            style: AppTextStyles.buttonLabel(context),
          ),
        ),
      ),
    );
  }
}
