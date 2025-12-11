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
  String? selectedType; // for_me or for_family
  String? selectedRelation; // Son/Daughter/Sister...

  final List<String> relations = [
    "Son",
    "Daughter",
    "Brother",
    "Sister",
    "Friend",
    "Relative",
  ];

  void _selectType(String type) {
    setState(() {
      selectedType = type;
      if (type == "for_me") {
        selectedRelation = null; // no relation needed
      }
    });
  }

  void _selectRelation(String r) {
    setState(() {
      selectedRelation = r;
    });
  }

  /// -------- Next Navigation ----------
  void _next() {
    if (selectedType != null) {
      BlocProvider.of<RegistrationBloc>(
        context,
      ).add(ProfileTypeSelected(selectedType!));

      // You can pass relation also if required
      Navigator.pushNamed(context, Routes.personal);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canProceed =
        selectedType == "for_me" ||
        (selectedType == "for_family" && selectedRelation != null);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.screenTopSpacing),

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
                    const SizedBox(height: 6),
                    Text(
                      AppStrings.letUsKnowForWhom,
                      style: AppTextStyles.heading(context),
                    ),

                    const SizedBox(height: 32),

                    /// ---------------- For Me ----------------
                    _buildOptionCard(
                      title: AppStrings.forMe,
                      subtitle: AppStrings.forMeSubtitle,
                      iconPath: AppAssets.forMeIcon,
                      isSelected: selectedType == "for_me",
                      onTap: () => _selectType("for_me"),
                    ),

                    const SizedBox(height: 16),

                    /// ---------------- For Family ----------------
                    _buildOptionCard(
                      title: AppStrings.forFamily,
                      subtitle: AppStrings.forFamilySubtitle,
                      iconPath: AppAssets.forFamilyIcon,
                      isSelected: selectedType == "for_family",
                      onTap: () => _selectType("for_family"),
                    ),

                    /// ------- Show relations only when family selected------
                    if (selectedType == "for_family") ...[
                      const SizedBox(height: 30),
                      Text(
                        "I'm creating a profile for my",
                        style: AppTextStyles.label(context),
                      ),

                      const SizedBox(height: 16),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          double itemWidth = (constraints.maxWidth - 32) / 3;   // Perfect 3 grid

                          return Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: relations.map((relation) {
                              final bool isActive = selectedRelation == relation;

                              return SizedBox(
                                width: itemWidth,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () => _selectRelation(relation),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    foregroundColor: isActive ? AppColors.primary : AppColors.textPrimary,
                                    side: BorderSide(
                                      color: isActive ? AppColors.primary : AppColors.border,
                                      width: isActive ? 2 : 1,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: FittedBox(                     // Auto fit text
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      relation,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,  // Prevent multi-line wrap
                                      style: AppTextStyles.body(context).copyWith(
                                        fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                                        color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],

                    const Spacer(),

                    /// ---------------- NEXT BUTTON ----------------
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: canProceed ? _next : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: canProceed
                              ? AppColors.primary
                              : AppColors.disabled,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          AppStrings.next,
                          style: AppTextStyles.buttonLabel(context),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// --------- Option Card Widget ----------
  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required String iconPath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // CARD
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(AppSizes.cardRadius),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppColors.primary.withOpacity(.15)
                        : AppColors.surface,
                  ),
                  child: Center(child: Image.asset(iconPath, width: 54)),
                ),
                const SizedBox(width: 16),
                Column(
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
                const Spacer(),
              ],
            ),
          ),

          /// ---- TOP RIGHT ROUNDED CORNER PATCH WITH TICK ----
          // ---- TOP RIGHT TRIANGLE WITH ROUNDED OUTER CORNER ----
          if (isSelected)
            Positioned(
              top: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(
                    12,
                  ), // <-- Rounded outer corner here
                ),
                child: CustomPaint(
                  size: const Size(42, 42),
                  painter: _TrianglePainter(AppColors.primary),
                  child: const SizedBox(
                    width: 48,
                    height: 48,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 6, right: 6),
                        child: Icon(Icons.check, size: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path()
      ..moveTo(size.width, 0) // keep angle EXACT same
      ..lineTo(size.width, size.height)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
