import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_assets.dart';
import '../core/constants/app_strings.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.bottomNavBarHeight,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.navBarBackground,
        borderRadius: BorderRadius.circular(AppSizes.bottomNavBarRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.navBarShadow,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: AppAssets.matches,
            label: AppStrings.matches,
            index: 0,
          ),
          _buildNavItem(
            icon: AppAssets.chat,
            label: AppStrings.chat,
            index: 1,
          ),
          _buildNavItem(
            icon: AppAssets.heart,
            label: AppStrings.likes,
            index: 2,
          ),
          _buildNavItem(
            icon: AppAssets.profile,
            label: AppStrings.profile,
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String icon,
    required String label,
    required int index,
  }) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              color: isSelected ? AppColors.primary : AppColors.navBarInactive,
              width: AppSizes.bottomNavIconSize,
              height: AppSizes.bottomNavIconSize,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.navBarInactive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}