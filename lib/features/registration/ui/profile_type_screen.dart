import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';

class ProfileTypeScreen extends StatefulWidget {
  const ProfileTypeScreen({super.key});

  @override
  State<ProfileTypeScreen> createState() => _ProfileTypeScreenState();
}

class _ProfileTypeScreenState extends State<ProfileTypeScreen> {
  String? selected;

  void _toggleSelection(String option) {
    setState(() {
      if (selected == option) {
        // Allow unselecting by tapping the same option
        selected = null;
      } else {
        selected = option;
      }
    });
  }

  void _next() {
    if (selected != null) {
      BlocProvider.of<RegistrationBloc>(
        context,
      ).add(ProfileTypeSelected(selected!));
      Navigator.of(context).pushNamed(Routes.personal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.screenTopSpacing),

            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.creatingAMatch,
                      style: AppTextStyles.heading(context),
                    ),
                    const SizedBox(height: AppSizes.smallSpacing),
                    Text(
                      AppStrings.letUsKnowForWhom,
                      style: AppTextStyles.heading(context),
                    ),

                    const SizedBox(height: AppSizes.largeSpacing * 2),

                    // For Me Option
                    _buildOptionCard(
                      title: AppStrings.forMe,
                      subtitle: AppStrings.forMeSubtitle,
                      iconPath: AppAssets.personIcon,
                      value: 'for_me',
                      isSelected: selected == 'for_me',
                      onTap: () => _toggleSelection('for_me'),
                    ),

                    const SizedBox(height: AppSizes.mediumSpacing),

                    /// TO-DO
                    // For Family Option
                    _buildOptionCard(
                      title: AppStrings.forFamily,
                      subtitle: AppStrings.forFamilySubtitle,
                      iconPath: AppAssets.personIcon,
                      value: 'for_family',
                      isSelected: selected == 'for_family',
                      onTap: () => (), /// _toggleSelection('for_family')
                    ),

                    const Spacer(),

                    // Next Button
                    _buildNextButton(),

                    const SizedBox(height: AppSizes.largeSpacing),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required String iconPath,
    required String value,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.mediumSpacing),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            // Main content
            Row(
              children: [
                Container(
                  width: AppSizes.iconSizeLarge * 1.5,
                  height: AppSizes.iconSizeLarge * 1.5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.1)
                        : AppColors.surface,
                  ),
                  child: Center(
                    child: Image.asset(
                      iconPath,
                      width: AppSizes.iconSizeMedium,
                      height: AppSizes.iconSizeMedium,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.mediumSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.bold(context).copyWith(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTextStyles.body(context).copyWith(
                          color: isSelected
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Corner checkmark indicator
            // if (isSelected)
            //   Positioned(
            //     top: 0,
            //     right: 0,
            //     child: ClipPath(
            //       clipper: CornerTriangleClipper(),
            //       child: Container(
            //         width: AppSizes.iconSizeLarge,
            //         height: AppSizes.iconSizeLarge,
            //         color: AppColors.primary,
            //         child: const Center(
            //           child: Icon(
            //             Icons.check,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            if (isSelected)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: AppSizes.iconSizeMedium,
                  height: AppSizes.iconSizeMedium,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Center(
                    child: Icon(Icons.check, size: 14, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    bool isEnabled = selected != null;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.06,
      child: ElevatedButton(
        onPressed: isEnabled ? _next : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? AppColors.primary : AppColors.disabled,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          padding: EdgeInsets.zero,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.textSecondary,
        ),
        child: Text(AppStrings.next, style: AppTextStyles.buttonLabel(context)),
      ),
    );
  }
}

class CornerTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width, 0); // Top-right corner
    path.lineTo(size.width, size.height); // Bottom-right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
