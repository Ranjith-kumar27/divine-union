import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../bloc/likes_bloc.dart';
import '../bloc/likes_event.dart';
import '../bloc/likes_state.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikesBloc(),
      child: const _LikesScreenContent(),
    );
  }
}

class _LikesScreenContent extends StatelessWidget {
  const _LikesScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<LikesBloc, LikesState>(
          builder: (context, state) {
            return Column(
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
                    state.subtitleText,
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
                      state.tabs.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 10, bottom: 10),
                        child: _buildTab(
                          context: context,
                          index: index,
                          label: state.tabs[index]["label"],
                          count: state.tabs[index]["count"],
                          isSelected: state.selectedIndex == index,
                        ),
                      ),
                    ),
                  ),
                ),

                /// CONTENT
                Expanded(child: _buildTabContent(state, context)),
              ],
            );
          },
        ),
      ),
    );
  }

  /// ---------------- TAB CONTENT SWITCH ----------------

  Widget _buildTabContent(LikesState state, BuildContext context) {
    switch (state.selectedIndex) {
      case 1:
        return state.likedByYouProfiles.isNotEmpty
            ? _likedByYouList(state.likedByYouProfiles)
            : _likedByYouEmpty(context);
      case 2:
        return state.mutualProfiles.isNotEmpty
            ? _mutualList(state.mutualProfiles)
            : _mutualEmpty(context);
      default:
        return state.likesYouProfiles.isNotEmpty
            ? _likesYouList(state.likesYouProfiles, context)
            : _likesYouEmpty(context);
    }
  }

  /// ---------------- LIKES YOU LIST ----------------

  Widget _likesYouList(
    List<Map<String, dynamic>> profiles,
    BuildContext context,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        final profile = profiles[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _profileCard(profile, context),
        );
      },
    );
  }

  /// ---------------- LIKED BY YOU LIST ----------------

  Widget _likedByYouList(List<Map<String, dynamic>> profiles) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.68, // matches image card ratio
      ),
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        final profile = profiles[index];
        return _likedByYouCard(profile);
      },
    );
  }

  /// ---------------- MUTUAL LIST ----------------

  Widget _mutualList(List<Map<String, dynamic>> profiles) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.68, // matches image card ratio
      ),
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        final profile = profiles[index];
        return _mutualCard(profile);
      },
    );
  }

  /// ----------------LIKES YOU - PROFILE CARD ----------------

  Widget _profileCard(Map<String, dynamic> profile, BuildContext context) {
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
                Positioned(top: 12, right: 12, child: _pill()),
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

  Widget _pill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.check_circle_outline_rounded,
            size: 14,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Text(
            "Verified",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- LIKED BY YOUR CARD ----------------

  Widget _likedByYouCard(Map<String, dynamic> profile) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(profile["image"]),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          /// Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.55)],
                ),
              ),
            ),
          ),

          /// MATCH %
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppAssets.whiteHeart, width: 12, height: 12),
                  const SizedBox(width: 4),
                  Text(
                    "${profile["match"]}%",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// DETAILS
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile["name"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  "${profile["location"]} · ${profile["age"]}",
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- MUTUAL CARD ----------------

  Widget _mutualCard(Map<String, dynamic> profile) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(profile["image"]),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          /// Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.55)],
                ),
              ),
            ),
          ),

          /// MATCH %
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppAssets.whiteHeart, width: 12, height: 12),
                  const SizedBox(width: 4),
                  Text(
                    "${profile["match"]}%",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// DETAILS
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile["name"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  "${profile["location"]} · ${profile["age"]}",
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- EMPTY STATES (UNCHANGED) ----------------

  Widget _likesYouEmpty(BuildContext context) {
    return _centerContent(
      context: context,
      icon: AppAssets.heartEmpty,
      title: "No Likes Yet",
      description:
          "When someone likes your profile, they'll appear here.\nKeep your profile updated!✨",
    );
  }

  Widget _likedByYouEmpty(BuildContext context) {
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

  Widget _mutualEmpty(BuildContext context) {
    return _centerContent(
      context: context,
      icon: AppAssets.mutualEmpty,
      title: "No matches yet",
      description:
          "When you both like each other, you'll see them here.\nIt's a match!💜",
    );
  }

  /// ---------------- COMMON ----------------

  Widget _centerContent({
    required BuildContext context,
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
    required BuildContext context,
    required int index,
    required String label,
    required int count,
    required bool isSelected,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        context.read<LikesBloc>().add(ChangeTab(index));
      },
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
}
