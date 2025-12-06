import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/otp_widgets.dart';
import '../../../routes.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';
import '../bloc/registration_state.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with CodeAutoFill {
  late String mobile;
  final List<TextEditingController> _otpControllers = [];
  final List<FocusNode> _focusNodes = [];
  bool _canVerify = false;
  int _remainingSeconds = 30;
  late Timer _timer;
  String? _appSignature;
  bool _isResending = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mobile = ModalRoute.of(context)?.settings.arguments as String? ?? '';
  }

  @override
  void codeUpdated() {
    final receivedCode = code!;
    if (receivedCode.length == 6) {
      _setOtpFromAutoFill(receivedCode);
    }
  }

  void _setOtpFromAutoFill(String code) {
    for (int i = 0; i < 6; i++) {
      if (i < code.length) {
        _otpControllers[i].text = code[i];
      }
    }
    _updateVerificationState();
  }

  @override
  void initState() {
    super.initState();
    _initializeOtpFields();
    _startTimer();
    _initSmsAutofill();
    listenForCode();
  }

  void _initSmsAutofill() async {
    _appSignature = await SmsAutoFill().getAppSignature;
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

  void _verify() {
    final otp = _otpControllers.map((c) => c.text).join();

    // Get the bloc
    final bloc = BlocProvider.of<RegistrationBloc>(context);

    // Get mobile from state
    final mobileFromState = bloc.state.mobile;

    // Use mobile from state if available, otherwise use the one from arguments
    final mobileToVerify = mobileFromState.isNotEmpty
        ? mobileFromState
        : mobile;

    // Dispatch event with mobile number
    bloc.add(OtpSubmitted(mobileToVerify, otp));
  }

  void _resendCode() {
    if (_remainingSeconds == 0 && !_isResending) {
      setState(() {
        _isResending = true;
      });

      // Get the bloc
      final bloc = BlocProvider.of<RegistrationBloc>(context);

      // Get mobile from state
      final mobileFromState = bloc.state.mobile;

      // Use mobile from state if available, otherwise use the one from arguments
      final mobileToResend = mobileFromState.isNotEmpty
          ? mobileFromState
          : mobile;

      // Dispatch resend OTP event
      bloc.add(ResendOtp(mobileToResend));

      // Restart timer
      _startTimer();

      // Reset resending flag after a delay
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isResending = false;
          });
        }
      });
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
    SmsAutoFill().unregisterListener();
    cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state.status == RegistrationStatus.verified) {
          // Navigate to profile type screen on successful verification
          Navigator.of(context).pushReplacementNamed(Routes.profileType);
        } else if (state.status == RegistrationStatus.failure &&
            state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Scaffold(
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
        body: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state) {
            return SafeArea(
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
                            // Show loading when resending OTP
                            _isResending
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Resending OTP...',
                                          style: AppTextStyles.body(
                                            context,
                                          ).copyWith(color: AppColors.primary),
                                        ),
                                      ],
                                    ),
                                  )
                                : OtpTimerWidget(
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
                  _buildVerifyButton(context, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVerifyButton(BuildContext context, RegistrationState state) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isLoading = state.status == RegistrationStatus.loading;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding,
        vertical: AppSizes.verticalPadding,
      ),
      child: SizedBox(
        width: double.infinity,
        height: screenHeight * 0.06,
        child: ElevatedButton(
          onPressed: (_canVerify && !isLoading) ? _verify : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: (_canVerify && !isLoading)
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
          child: isLoading
              ? const SpinKitWave(
                  color: Colors.white,
                  size: 20.0,
                  type: SpinKitWaveType.start,
                )
              : Text(
                  AppStrings.verifyCode,
                  style: AppTextStyles.buttonLabel(context),
                ),
        ),
      ),
    );
  }
}
