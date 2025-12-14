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

  /// ---------------- DUMMY DATA (API READY) ----------------
  final List<Map<String, dynamic>> _likesYouProfiles = [
    {
      "image":
          "https://i.pinimg.com/1200x/e8/5e/10/e85e1004513e5d550e4094ed6640ae88.jpg",
      "name": "Emily Johnson",
      "age": 26,
      "match": 94,
      "height": "5'10",
      "job": "UI/UX Designer",
      "education": "M.Des",
      "location": "Mumbai, Maharashtra",
    },
    {
      "image":
          "https://i.pinimg.com/1200x/b6/62/de/b662deb210fbc898489ac2031a3abdf7.jpg",
      "name": "Olivia Brown",
      "age": 25,
      "match": 92,
      "height": "5'10",
      "job": "Product Analyst",
      "education": "MBA",
      "location": "Pune, Maharashtra",
    },
    {
      "image":
          "https://i.pinimg.com/originals/7e/61/37/7e613711bbcc148dde2ff971b969ba9d.png",
      "name": "Sarah Williams",
      "age": 24,
      "match": 96,
      "height": "5'10",
      "job": "Software Engineer",
      "education": "B.Tech in Computer Science",
      "location": "Bangalore, Karnataka",
    },
  ];

  final List<Map<String, dynamic>> _likedByYouProfiles = [];
  final List<Map<String, dynamic>> _mutualProfiles = [];

  final List<Map<String, dynamic>> _tabs = [
    {"label": "Likes you", "count": 1},
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

            /// TITLE
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

            /// SUBTITLE
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

            /// TABS
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.mediumSpacing,
              ),
              child: Row(
                children: List.generate(
                  _tabs.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 10),
                    child: _buildTab(
                      index: index,
                      label: _tabs[index]["label"],
                      count: _tabs[index]["count"],
                    ),
                  ),
                ),
              ),
            ),

            /// CONTENT
            Expanded(child: _buildTabContent()),
          ],
        ),
      ),
    );
  }

  /// ---------------- TAB CONTENT SWITCH ----------------

  Widget _buildTabContent() {
    switch (_selectedIndex) {
      case 1:
        return _likedByYouProfiles.isNotEmpty
            ? _likedByYouList()
            : _likedByYouEmpty();
      case 2:
        return _mutualProfiles.isNotEmpty ? _mutualList() : _mutualEmpty();
      default:
        return _likesYouProfiles.isNotEmpty
            ? _likesYouList()
            : _likesYouEmpty();
    }
  }

  /// ---------------- LIKES YOU LIST ----------------

  Widget _likesYouList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      itemCount: _likesYouProfiles.length,
      itemBuilder: (context, index) {
        final profile = _likesYouProfiles[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _profileCard(profile),
        );
      },
    );
  }

  /// ---------------- LIKED BY YOU LIST ----------------

  Widget _likedByYouList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      itemCount: _likedByYouProfiles.length,
      itemBuilder: (context, index) {
        final profile = _likedByYouProfiles[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _profileCard(profile),
        );
      },
    );
  }

  /// ---------------- MUTUAL LIST ----------------

  Widget _mutualList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      itemCount: _mutualProfiles.length,
      itemBuilder: (context, index) {
        final profile = _mutualProfiles[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _profileCard(profile),
        );
      },
    );
  }

  /// ---------------- PROFILE CARD ----------------

  Widget _profileCard(Map<String, dynamic> profile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(
              children: [
                Image.network(
                  profile["image"],
                  height: 320,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, -0.8),
                ),

                /// MATCH %
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppAssets.whiteHeart,
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "${profile["match"]}%",
                          style: AppTextStyles.body(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// VERIFIED
                Positioned(
                  top: 12,
                  right: 12,
                  child: _pill("Verified", Colors.blue),
                ),
              ],
            ),
          ),

          /// DETAILS
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${profile["name"]}, ${profile["age"]}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Lora',
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "${profile["height"]}''",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.job),
                    const SizedBox(width: 6),
                    Text(
                      profile["job"],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.education),
                    const SizedBox(width: 6),
                    Text(
                      profile["education"],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.location),
                    const SizedBox(width: 6),
                    Text(
                      profile["location"],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                /// ACTIONS
                Row(
                  children: [
                    /// PASS
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AppAssets.pass,
                            width: 18,
                            height: 18,
                          ),
                          label: const Text("Pass"),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.liteDisabled,
                            foregroundColor: AppColors.textTertiary,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            textStyle: AppTextStyles.body(
                              context,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// ACCEPT
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AppAssets.heart,
                            width: 18,
                            height: 18,
                            color: Colors.white,
                          ),
                          label: const Text("Accept"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            textStyle: AppTextStyles.body(
                              context,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
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

  /// ---------------- HELPERS ----------------

  Widget _pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// ---------------- EMPTY STATES (UNCHANGED) ----------------

  Widget _likesYouEmpty() {
    return _centerContent(
      icon: AppAssets.heartEmpty,
      title: "No Likes Yet",
      description:
          "When someone likes your profile, they'll appear here.\nKeep your profile updated!✨",
    );
  }

  Widget _likedByYouEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _circleIcon(AppAssets.heartCard),
        const SizedBox(height: 16),
        Text(
          "Start Exploring",
          style: AppTextStyles.heading(context).copyWith(fontSize: 20),
        ),
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
        const SizedBox(height: 12),
        Container(
          width: 250,
          height: 52,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
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
              mainAxisAlignment: MainAxisAlignment.center,
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
      ],
    );
  }

  Widget _mutualEmpty() {
    return _centerContent(
      icon: AppAssets.mutualEmpty,
      title: "No matches yet",
      description:
          "When you both like each other, you'll see them here.\nIt's a match!💜",
    );
  }

  /// ---------------- COMMON ----------------

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
      case 0: // Likes You
        return _likesYouProfiles.isNotEmpty
            ? "Someone's got their eyes on you. ✨"
            : "Your perfect match is just around the corner ✨";

      case 1: // Liked by You
        return _likedByYouProfiles.isNotEmpty
            ? "You made the first move. 💫"
            : "Start connecting with people you like 💫";

      case 2: // Mutual
        return _mutualProfiles.isNotEmpty
            ? "Find your special someone today 💜"
            : "Find your special someone today 💜";

      default:
        return "";
    }
  }
}
