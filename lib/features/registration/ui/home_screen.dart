import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../navigation/custom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding,
                vertical: AppSizes.mediumSpacing,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.matchingProfiles,
                        style: AppTextStyles.heading(context),
                      ),
                    ],
                  ),
                  Container(
                    width: AppSizes.iconButtonSize,
                    height: AppSizes.iconButtonSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: IconButton(
                      icon: SvgPicture.asset(
                        AppAssets.settings,
                        color: AppColors.textPrimary,
                        width: AppSizes.iconSizeMedium,
                        height: AppSizes.iconSizeMedium,
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.divider, height: 1),
            const SizedBox(height: AppSizes.largeSpacing),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontalPadding,
                ),
                child: Column(
                  children: [
                    // Match percentage card
                    Container(
                      padding: const EdgeInsets.all(AppSizes.smallSpacing),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          AppSizes.cardRadius,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile card
                          Container(
                            height: AppSizes.profileCardHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppSizes.profileImageRadius,
                              ),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://i.pinimg.com/736x/db/7f/f0/db7ff061ac663fe1605912598635b8b8.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                // Gradient overlay
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.profileImageRadius,
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        AppColors.profileGradientEnd,
                                        AppColors.profileGradientStart,
                                      ],
                                    ),
                                  ),
                                ),

                                // Profile info at bottom
                                Positioned(
                                  bottom: AppSizes.largeSpacing,
                                  left: AppSizes.largeSpacing,
                                  right: AppSizes.largeSpacing,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSizes.mediumSpacing,
                                          vertical: AppSizes.smallSpacing,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                          AppColors.premiumBadgeBackground,
                                          borderRadius: BorderRadius.circular(
                                            AppSizes.tagRadius,
                                          ),
                                        ),
                                        child: Text(
                                          '98% Match',
                                          style: AppTextStyles.premiumBadge(
                                            context,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Amala Grace, 23',
                                        style: AppTextStyles.profileName(
                                          context,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: AppSizes.smallSpacing,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal:
                                              AppSizes.mediumSpacing,
                                              vertical: AppSizes.smallSpacing,
                                            ),
                                            child: Text(
                                              AppStrings.christian,
                                              style: AppTextStyles.profileTag(
                                                context,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: AppSizes.smallSpacing,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal:
                                              AppSizes.mediumSpacing,
                                              vertical: AppSizes.smallSpacing,
                                            ),
                                            child: Text(
                                              AppStrings.kapuChristians,
                                              style: AppTextStyles.profileTag(
                                                context,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: AppSizes.smallSpacing,
                                      ),
                                      Positioned(
                                        bottom: AppSizes.largeSpacing,
                                        right: AppSizes.largeSpacing,
                                        child: Row(
                                          children: [
                                            _buildActionButton(
                                              icon: AppAssets.cancel,
                                              // backgroundColor: Colors.white,
                                              shadowColor:
                                              AppColors.dislikeButtonShadow,
                                            ),
                                            const SizedBox(
                                              width: AppSizes.mediumSpacing,
                                            ),
                                            _buildActionButton(
                                              icon: AppAssets.like,
                                              // backgroundColor: AppColors.primary,
                                              shadowColor:
                                              AppColors.likeButtonShadow,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Like/Dislike buttons
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Additional sections placeholder
                    const SizedBox(height: AppSizes.extraLargeSpacing),
                    _buildSectionTitle(context, AppStrings.suggestedProfiles),
                    const SizedBox(height: AppSizes.largeSpacing),
                    _buildSuggestedProfiles(context),
                    const SizedBox(height: AppSizes.extraLargeSpacing),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String icon,
    // required Color backgroundColor,
    required Color shadowColor,
  }) {
    return Container(
      width: AppSizes.actionButtonSize,
      height: AppSizes.actionButtonSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: AppSizes.iconSizeMedium,
          height: AppSizes.iconSizeMedium,
          // color: backgroundColor == Colors.white
          //     ? AppColors.textPrimary
          //     : Colors.white,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.sectionTitle(context)),
        TextButton(
          onPressed: () {},
          child: Text(AppStrings.seeAll, style: AppTextStyles.seeAll(context)),
        ),
      ],
    );
  }

  Widget _buildSuggestedProfiles(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildProfileCard(
            context,
            imageUrl:
            'https://i.pinimg.com/736x/db/7f/f0/db7ff061ac663fe1605912598635b8b8.jpg',
            name: 'Sarah',
            age: 25,
            matchPercentage: 92,
          ),
          const SizedBox(width: AppSizes.mediumSpacing),
          _buildProfileCard(
            context,
            imageUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80',
            name: 'Priya',
            age: 24,
            matchPercentage: 88,
          ),
          const SizedBox(width: AppSizes.mediumSpacing),
          _buildProfileCard(
            context,
            imageUrl:
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
            name: 'Jessica',
            age: 26,
            matchPercentage: 85,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(
      BuildContext context, {
        required String imageUrl,
        required String name,
        required int age,
        required int matchPercentage,
      }) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSizes.cardRadius),
                topRight: Radius.circular(AppSizes.cardRadius),
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.mediumSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name, $age',
                  style: AppTextStyles.suggestedProfileName(context),
                ),
                const SizedBox(height: AppSizes.smallSpacing),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.smallSpacing,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppSizes.tagRadius),
                      ),
                      child: Text(
                        '$matchPercentage% Match',
                        style: AppTextStyles.suggestedMatchPercentage(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
