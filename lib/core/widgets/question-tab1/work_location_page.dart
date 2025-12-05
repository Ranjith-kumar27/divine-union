import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../bottomsheet/custom_bottom_sheet.dart';

class WorkLocationPage extends StatelessWidget {
  final String? selectedCity;
  final String? selectedCountry;
  final ValueChanged<String> onCitySelected;
  final ValueChanged<String> onCountrySelected;

  const WorkLocationPage({
    super.key,
    required this.selectedCity,
    required this.selectedCountry,
    required this.onCitySelected,
    required this.onCountrySelected,
  });

  static const cities = [
    "Pollachi",
    "Coimbatore",
    "Chennai",
    "Bangalore",
    "Mumbai",
  ];

  static const countries = [
    "India",
    "USA",
    "UK",
    "Australia",
    "Canada",
  ];

  void _showCityBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomBottomSheet.locationSelection(
        title: 'Select Work City',
        options: cities,
        selectedValue: selectedCity,
        onSelect: onCitySelected,
        showSearch: true,
        heightFactor: 0.7,
      ),
    );
  }

  void _showCountryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomBottomSheet.locationSelection(
        title: 'Select Work Country',
        options: countries,
        selectedValue: selectedCountry,
        onSelect: onCountrySelected,
        showSearch: true,
        heightFactor: 0.7,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Where do you work?",
              style: AppTextStyles.heading(context),
            ),
            const SizedBox(height: AppSizes.largeSpacing),

            // CITY SELECTION FIELD
            const Text("Work City"),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _showCityBottomSheet(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCity ?? "Select City",
                      style: TextStyle(
                        fontSize: 16,
                        color: selectedCity != null
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSizes.largeSpacing),

            // COUNTRY SELECTION FIELD
            const Text("Work Country"),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _showCountryBottomSheet(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCountry ?? "Select Country",
                      style: TextStyle(
                        fontSize: 16,
                        color: selectedCountry != null
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
