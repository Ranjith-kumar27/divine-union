import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../navigation/custom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final CardSwiperController _swiperController = CardSwiperController();

  final List<Map<String, dynamic>> _profiles = [
    {
      "image":
      "https://images.unsplash.com/photo-1544005313-94ddf0286df2",
      "name": "Sarah Williams",
      "age": 24,
      "match": 96,
    },
    {
      "image":
      "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
      "name": "Emily Johnson",
      "age": 26,
      "match": 94,
    },
    {
      "image":
      "https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91",
      "name": "Olivia Brown",
      "age": 25,
      "match": 92,
    },
    {
      "image":
      "https://images.unsplash.com/photo-1517841905240-472988babdf9",
      "name": "Sophia Martinez",
      "age": 23,
      "match": 97,
    },
    {
      "image":
      "https://images.unsplash.com/photo-1520813792240-56fc4a3765a7",
      "name": "Isabella Garcia",
      "age": 27,
      "match": 91,
    },
    {
      "image":
      "https://images.unsplash.com/photo-1534528741775-53994a69daeb",
      "name": "Ava Thompson",
      "age": 24,
      "match": 95,
    },
    {
      "image":
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
      "name": "Mia Anderson",
      "age": 22,
      "match": 93,
    },
    {
      "image":
      "https://images.unsplash.com/photo-1548142813-c348350df52b",
      "name": "Charlotte Lee",
      "age": 28,
      "match": 90,
    },
    {
      "image":
      "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
      "name": "Amelia Wilson",
      "age": 26,
      "match": 94,
    },
    {
      "image":
      "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f",
      "name": "Harper Collins",
      "age": 25,
      "match": 96,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const Divider(height: 1),
            const SizedBox(height: AppSizes.mediumSpacing),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.mediumSpacing,
                ),
                child: CardSwiper(
                  controller: _swiperController,
                  cardsCount: _profiles.length,
                  isLoop: true,
                  allowedSwipeDirection:
                  const AllowedSwipeDirection.only(
                    left: true,
                    right: true,
                  ),
                  onSwipe: (prev, curr, direction) => true,
                  cardBuilder: (BuildContext context, int index, int horizontalOffsetPercentage, int verticalOffsetPercentage) {
                    final profile = _profiles[index];
                    return _buildProfileCard(context, profile);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
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
          Container(
            width: AppSizes.iconButtonSize,
            height: AppSizes.iconButtonSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: SvgPicture.asset(
                AppAssets.settings,
                width: AppSizes.iconSizeMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* PROFILE CARD */
  Widget _buildProfileCard(
      BuildContext context, Map<String, dynamic> profile) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.profileImageRadius),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(profile['image'], fit: BoxFit.cover),

          // Gradient
          Container(
            decoration: BoxDecoration(
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

          // Profile Info
          Positioned(
            bottom: 120,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.premiumBadgeBackground,
                    borderRadius: BorderRadius.circular(AppSizes.tagRadius),
                  ),
                  child: Text(
                    "${profile['match']}% Match",
                    style: AppTextStyles.premiumBadge(context),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "${profile['name']}, ${profile['age']}",
                  style: AppTextStyles.profileName(context),
                ),
                const SizedBox(height: 6),
                Text(
                  "${AppStrings.christian} • ${AppStrings.kapuChristians}",
                  style: AppTextStyles.profileTag(context),
                ),
              ],
            ),
          ),

          // Actions
          Positioned(
            bottom: 42,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _actionButton(
                  icon: AppAssets.cancel,
                  shadow: AppColors.dislikeButtonShadow,
                  onTap: () =>
                      _swiperController.swipe(CardSwiperDirection.left),
                ),
                const SizedBox(width: 32),
                _actionButton(
                  icon: AppAssets.like,
                  shadow: AppColors.likeButtonShadow,
                  onTap: () =>
                      _swiperController.swipe(CardSwiperDirection.right),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String icon,
    required Color shadow,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSizes.actionButtonSize,
        height: AppSizes.actionButtonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: shadow,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            icon,
            width: AppSizes.actionButtonSize,
          ),
        ),
      ),
    );
  }
}
