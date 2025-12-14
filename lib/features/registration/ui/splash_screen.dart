import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes.dart';
import '../../../services/verification_storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkVerificationStatus();
  }

  Future<void> _checkVerificationStatus() async {
    // Wait for splash duration
    await Future.delayed(const Duration(milliseconds: 2000));

    if (!mounted) return;

    // Check if user is verified
    final bool isVerified = await VerificationStorageService.isVerified();

    if (isVerified) {
      // User is verified, go to profile type with clearing stack
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.main,
        (route) => false, // Clear all routes
      );
    } else {
      // User not verified, go to mobile number screen
      Navigator.of(context).pushReplacementNamed(Routes.mobileNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Text(
          'DVUN',
          style: AppTextStyles.heading(context).copyWith(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
