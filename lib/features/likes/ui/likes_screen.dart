import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _tabs = [
    {"label": "Likes you", "count": 0},
    {"label": "Liked by you", "count": 0},
    {"label": "Mutual", "count": 0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.mediumSpacing),

            /// Title
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding,
                vertical: 12,
              ),
              child: Text(
                AppStrings.likes,
                style: AppTextStyles.heading(context),
              ),
            ),

            /// Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding,
              ),
              child: Text(
                _subtitleText,
                style: AppTextStyles.body(
                  context,
                ).copyWith(color: Colors.grey[600]),
              ),
            ),

            const SizedBox(height: 20),

            /// Tabs
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.mediumSpacing,
              ),
              child: Row(
                children: List.generate(
                  _tabs.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _buildTab(
                      index: index,
                      label: _tabs[index]["label"],
                      count: _tabs[index]["count"],
                    ),
                  ),
                ),
              ),
            ),

            /// Content
            Expanded(child: _buildTabContent()),
          ],
        ),
      ),
    );
  }

  /// ---------------- TAB CONTENT ----------------

  Widget _buildTabContent() {
    switch (_selectedIndex) {
      case 1:
        return _likedByYouEmpty();
      case 2:
        return _mutualEmpty();
      default:
        return _likesYouEmpty();
    }
  }

  /// Likes You (EMPTY)
  Widget _likesYouEmpty() {
    return _centerContent(
      icon: AppAssets.heartEmpty,
      title: "No Likes Yet",
      description:
          "When someone likes your profile, they'll appear here.\nKeep your profile updated!✨",
    );
  }

  /// Liked By You (EMPTY)
  Widget _likedByYouEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _circleIcon(AppAssets.heartCard),

        Text(
          "Start Exploring",
          style: AppTextStyles.heading(context).copyWith(fontSize: 20),
        ),

        // const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Like profiles to see them here and increase your chances of finding your match💫",
            textAlign: TextAlign.center,
            style: AppTextStyles.body(
              context,
            ).copyWith(color: Colors.grey[600]),
          ),
        ),

        const SizedBox(height: 4),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppAssets.whiteHeart),
                  const SizedBox(width: 10),
                  Text(
                    AppStrings.exploreMatches,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Mutual (EMPTY)
  Widget _mutualEmpty() {
    return _centerContent(
      icon: AppAssets.mutualEmpty,
      title: "No matches yet",
      description:
          "When you both like each other, you'll see them here.\nIt's a match!💜",
    );
  }

  /// ---------------- COMMON WIDGETS ----------------

  Widget _centerContent({
    required String icon,
    required String title,
    required String description,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _circleIcon(icon),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTextStyles.heading(context).copyWith(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: AppTextStyles.body(
                context,
              ).copyWith(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleIcon(String asset) {
    return SvgPicture.asset(asset);
  }

  /// ---------------- TAB BUTTON ----------------

  Widget _buildTab({
    required int index,
    required String label,
    required int count,
  }) {
    final bool isSelected = _selectedIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.liteDisabled,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 6),

            /// Count Circle
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : AppColors.border,
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- SUBTITLE ----------------

  String get _subtitleText {
    switch (_selectedIndex) {
      case 1:
        return "Start connecting with people you like💫";
      case 2:
        return "Find your special someone today💜";
      default:
        return "Your perfect match is just around the corner✨";
    }
  }
}
