import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes.dart';

class PerfectMatchScreen extends StatelessWidget {
  const PerfectMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final headingStyle = AppTextStyles.heading(context).copyWith(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );

    final subTextStyle = AppTextStyles.body(context).copyWith(
      fontSize: 16,
      color: Colors.white.withOpacity(0.85),
      height: 1.5,
    );

    final buttonTextPrimary = AppTextStyles.buttonLabel(context).copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),

              Text('Find Your Perfect Match',
                  style: headingStyle, textAlign: TextAlign.center),

              const SizedBox(height: 16),

              Text(
                'Find your perfect match and begin a beautiful journey together',
                style: subTextStyle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),
              SvgPicture.asset(AppAssets.couple),

              const Spacer(),

              _buildPrimaryButton(context, buttonTextPrimary),
              const SizedBox(height: 16),
              _buildOutlineButton(context, buttonTextPrimary),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context, TextStyle style) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          ),
          elevation: 0,
        ),
        child: Text('Get Started', style: style.copyWith(color: AppColors.primary)),
      ),
    );
  }

  Widget _buildOutlineButton(BuildContext context, TextStyle style) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: OutlinedButton(
        onPressed: () => Navigator.pushNamed(context, Routes.mobileNumber),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          ),
        ),
        child: Text('Log in', style: style.copyWith(color: Colors.white)),
      ),
    );
  }
}
