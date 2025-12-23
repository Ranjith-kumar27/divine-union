import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dummy data
  final Map<String, dynamic> _profileData = {
    "image":
        "https://i.pinimg.com/736x/3e/86/1c/3e861cace82afdabcfbd7d5d354edda4.jpg",
    "name": "Rebecca Antony",
    "age": 27,
    "location": "Chennai, Tamilnadu",
    "match": 95,
    "quote":
        "Numbers tell stories, but faith writes mine. Looking for a partner to share life's journey.",
    "basicDetails": [
      {"icon": AppAssets.info, "label": "5'5\""},
      {"icon": null, "label": "15-05-1997"},
      {"icon": AppAssets.female, "label": "Female"},
    ],
    "sections": [
      {
        "title": "Faith & Church",
        "items": [
          {"label": "Catholic", "icon": null}, // In UI this has a church icon
          {"label": "Weekly", "icon": null},
          {"label": "Strong & Serving", "icon": null},
        ],
      },
      {
        "title": "Involvement",
        "items": [
          {"label": "Active in Ministry", "icon": null},
          {"label": "Bible Study", "icon": null},
        ],
      },
      {
        "title": "Spiritual Practices",
        "items": [
          {"label": "Prayer & Bible", "icon": null},
          {"label": "Worship Music", "icon": null},
          {"label": "Fellowship", "icon": null},
        ],
      },
      {
        "title": "Ministry Calling",
        "items": [
          {"label": "Youth Ministry", "icon": null},
        ],
      },
      {
        "title": "Education & Career",
        "items": [
          {"label": "Bachelor's", "icon": AppAssets.education},
          {"label": "Software Engineer", "icon": AppAssets.job},
          {"label": "Chennai", "icon": AppAssets.location},
        ],
      },
      {
        "title": "Career Approach & Flexibility",
        "items": [
          {"label": "Balanced", "icon": null},
          {"label": "Open within India", "icon": null},
        ],
      },
      {
        "title": "Lifestyle",
        "items": [
          {"label": "Vegetarian", "icon": null},
          {"label": "Non-Drinker", "icon": null},
          {"label": "Non-Smoker", "icon": null},
        ],
      },
      {
        "title": "Values & Choices",
        "items": [
          {"label": "Health Conscious", "icon": null},
          {"label": "Tradition Keeper", "icon": null},
          {"label": "Introvert", "icon": null},
          {"label": "Learner", "icon": null},
        ],
      },
      {
        "title": "Languages",
        "items": [
          {"label": "Tamil", "icon": null},
          {"label": "English", "icon": null},
          {"label": "Hindi", "icon": null},
        ],
      },
      {
        "title": "Family Background",
        "items": [
          {"label": "Nuclear Family", "icon": null},
          {"label": "1 Brother (Married)", "icon": null},
          {"label": "Family Essential", "icon": null},
          {"label": "Father: Retired Government Officer", "icon": null},
          {"label": "Mother: Homemaker", "icon": null},
        ],
      },
      {
        "title": "Interests & Personality",
        "items": [
          {"label": "Worship Music", "icon": null},
          {"label": "Reading", "icon": null},
          {"label": "Family Time", "icon": null},
          {"label": "Cooking", "icon": null},
          {"label": "Volunteering", "icon": null},
        ],
      },
      {
        "title": "Personality",
        "items": [
          {"label": "Thoughtful", "icon": null},
          {"label": "Caring", "icon": null},
          {"label": "Loyal", "icon": null},
        ],
      },
      {
        "title": "Christ Centered Life",
        "items": [
          {"label": "Prayer & Worship", "icon": null},
          {"label": "Faith-Filled Home", "icon": null},
          {"label": "Raise Christian Family", "icon": null},
        ],
      },
      {
        "title": "Looking For",
        "items": [
          {"label": "Deep Faith", "icon": null},
          {"label": "Active in Church", "icon": null},
          {"label": "Kind & Mature", "icon": null},
          {"label": "Shared Values", "icon": null},
          {"label": "Good Communication", "icon": null},
          {"label": "26-32 years", "icon": null},
          {"label": "5'7\" and above", "icon": null},
        ],
      },
      {
        "title": "Vision for Marriage",
        "items": [
          {"label": "Christ-Centered Home", "icon": null},
          {"label": "Support Dreams & Serve", "icon": null},
          {"label": "Family Legacy", "icon": null},
          {"label": "Definitely Want Kids", "icon": null},
          {"label": "2 Children", "icon": null},
        ],
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: AppSizes.mediumSpacing),
                    // 1. Profile Image Section
                    _buildProfileImageCard(context),

                    const SizedBox(height: 24),

                    // 3. Details Card (Wrapper for all sections)
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppSizes.horizontalPadding,
                      ),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.border.withOpacity(0.5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\"${_profileData['quote']}\"",
                            style: AppTextStyles.body(context).copyWith(
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                              fontFamily: 'Intel',
                              fontWeight: FontWeight.w500,
                              height: 1.6,
                              color: const Color(0xFF101026),
                            ),
                            textAlign: TextAlign.start,
                          ),

                          SizedBox(height: 24),

                          // Basic Details
                          Text(
                            "Basic Details",
                            style: AppTextStyles.subheading(context).copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Lora',
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: (_profileData['basicDetails'] as List)
                                .map<Widget>((detail) {
                                  return _buildChip(
                                    context,
                                    detail['label'],
                                    icon: detail['icon'],
                                    isBasic: true,
                                  );
                                })
                                .toList(),
                          ),

                          const SizedBox(height: 32),

                          // Dynamic Sections
                          ...(_profileData['sections'] as List).map((section) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  section['title'],
                                  style: AppTextStyles.subheading(context)
                                      .copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Lora',
                                      ),
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 12,
                                  children: (section['items'] as List)
                                      .map<Widget>((item) {
                                        return _buildChip(
                                          context,
                                          item['label'],
                                          icon: item['icon'],
                                        );
                                      })
                                      .toList(),
                                ),
                                const SizedBox(height: 24),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // 4. Action Buttons at Bottom
                    _buildActionButtons(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* HEADER */
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding,
        vertical: AppSizes.mediumSpacing,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.matchingProfiles,
            style: AppTextStyles.heading(context),
          ),
          SizedBox(
            width: AppSizes.iconButtonSize,
            height: AppSizes.iconButtonSize,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: SvgPicture.asset(
                AppAssets.settings,
                width: AppSizes.iconSizeMedium,
                colorFilter: const ColorFilter.mode(
                  AppColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImageCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: SizedBox(
          height: 420, // Adjusted height
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                _profileData['image'],
                fit: BoxFit.cover,
                // Error builder in case network fails
                errorBuilder: (ctx, err, stack) =>
                    Container(color: Colors.grey.shade200),
              ),
              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.8),
                    ],
                    stops: const [0.6, 0.75, 1.0],
                  ),
                ),
              ),
              // Badges
              Positioned(
                top: 20,
                left: 20,
                child: _buildBadge(
                  context,
                  iconPath: AppAssets.heart,
                  text: "${_profileData['match']}%",
                  color: AppColors.primary,
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: _buildBadge(
                  context,
                  iconPath: AppAssets.whiteHeart,
                  text: "Verified",
                  color: const Color(0xFF3B82F6), // Blue
                ),
              ),
              // Name and Details
              Positioned(
                bottom: 24,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${_profileData['name']}, ${_profileData['age']}",
                      style: AppTextStyles.heading(context).copyWith(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Lora',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _profileData['location'],
                      style: AppTextStyles.body(context).copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(
    BuildContext context, {
    required String iconPath,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 14,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppTextStyles.label(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(
    BuildContext context,
    String label, {
    String? icon,
    bool isBasic = false,
  }) {
    Color bg = const Color(0xFFF9FAFB);
    Color initialTextColor = const Color(0xFF6B7280); // Gray text by default?
    // In Figma:
    // Basic Details: Purple tint bg, Purple text
    // Regular Tags: Gray variant? Or Purple?
    // The previous code had 0xFF6A6AF0 (Primary) text.
    // Let's use a soft purple bg for chips if they are "selections" or characteristics.

    // UI Screenshot check: "Catholic" has icon. "Weekly" has calendar icon.
    // Text is dark. Background is very light blue/purple (0xFFEEF2FF maybe).

    // Let's go with a premium look:
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.liteDisabled, // Slightly darker than white
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            SvgPicture.asset(
              icon,
              width: 16,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: AppTextStyles.label(context).copyWith(
              color: const Color(0xFF374151), // Dark gray text
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _actionButton(icon: AppAssets.cancel, onTap: () {}, isLike: false),
        const SizedBox(width: 24),
        _actionButton(icon: AppAssets.like, onTap: () {}, isLike: true),
      ],
    );
  }

  Widget _actionButton({
    required String icon,
    required VoidCallback onTap,
    required bool isLike,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: isLike ? AppColors.primary : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: isLike
                  ? AppColors.primary.withOpacity(0.3)
                  : Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          border: isLike ? null : Border.all(color: AppColors.border),
        ),
        child: Center(child: SvgPicture.asset(icon)),
      ),
    );
  }
}
