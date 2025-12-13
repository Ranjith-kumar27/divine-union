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
      "https://i.pinimg.com/736x/3e/86/1c/3e861cace82afdabcfbd7d5d354edda4.jpg",
      "name": "Sarah Williams",
      "age": 24,
      "match": 96,
    },
    {
      "image":
      "https://i.pinimg.com/1200x/e8/5e/10/e85e1004513e5d550e4094ed6640ae88.jpg",
      "name": "Emily Johnson",
      "age": 26,
      "match": 94,
    },
    {
      "image":
      "https://i.pinimg.com/1200x/29/65/b9/2965b94b6b98dcc95e306f9665c71713.jpg",
      "name": "Olivia Brown",
      "age": 25,
      "match": 92,
    },
    {
      "image":
      "https://i.pinimg.com/1200x/24/0b/29/240b2912880da864e767dddbefb9f4be.jpg",
      "name": "Sophia Martinez",
      "age": 23,
      "match": 97,
    },
    {
      "image":
      "https://i.pinimg.com/736x/96/6c/11/966c11c2de865314f078cc34becd2670.jpg",
      "name": "Isabella Garcia",
      "age": 27,
      "match": 91,
    },
    {
      "image":
      "https://i.pinimg.com/1200x/96/0e/6c/960e6cc2da83705a8e1ea685527290b3.jpg",
      "name": "Ava Thompson",
      "age": 24,
      "match": 95,
    },
    {
      "image":
      "https://i.pinimg.com/736x/70/70/1a/70701a672ecdd1bbaa8400a04977e718.jpg",
      "name": "Mia Anderson",
      "age": 22,
      "match": 93,
    },
    {
      "image":
      "https://i.pinimg.com/736x/2e/63/21/2e632194a21a7fc18e2ada8f276531e5.jpg",
      "name": "Charlotte Lee",
      "age": 28,
      "match": 90,
    },
    {
      "image":
      "https://i.pinimg.com/originals/7e/61/37/7e613711bbcc148dde2ff971b969ba9d.png",
      "name": "Amelia Wilson",
      "age": 26,
      "match": 94,
    },
    {
      "image":
      "https://i.pinimg.com/1200x/b6/62/de/b662deb210fbc898489ac2031a3abdf7.jpg",
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
