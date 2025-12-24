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
    final screenHeight = MediaQuery.of(context).size.height;

    // Proportional font sizes based on screenHeight
    final headingStyle = AppTextStyles.heading(context).copyWith(
      fontSize: (screenHeight * 0.038).clamp(24.0, 32.0),
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );

    final subTextStyle = AppTextStyles.body(context).copyWith(
      fontSize: (screenHeight * 0.019).clamp(14.0, 16.0),
      color: Colors.white.withOpacity(0.85),
      height: 1.5,
    );

    final buttonTextPrimary = AppTextStyles.buttonLabel(context).copyWith(
      fontSize: (screenHeight * 0.019).clamp(14.0, 16.0),
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 18.0,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.08),

                        Text(
                          'Find Your Perfect Match',
                          style: headingStyle,
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 16),

                        Text(
                          'Find your perfect match and begin a beautiful journey together',
                          style: subTextStyle,
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: screenHeight * 0.04),

                        Flexible(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: screenHeight * 0.4,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.couple,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                        _buildPrimaryButton(context, buttonTextPrimary),
                        const SizedBox(height: 16),
                        _buildOutlineButton(context, buttonTextPrimary),

                        SizedBox(
                          height: (screenHeight * 0.05).clamp(20.0, 40.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
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
        child: Text(
          'Get Started',
          style: style.copyWith(color: AppColors.primary),
        ),
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
