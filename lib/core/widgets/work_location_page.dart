import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';

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

            // CITY
            const Text("Work City"),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: const SizedBox(),
                value: selectedCity ?? cities.first,
                items: cities
                    .map((c) =>
                    DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) onCitySelected(value);
                },
              ),
            ),

            const SizedBox(height: AppSizes.largeSpacing),

            // COUNTRY
            const Text("Work Country"),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: const SizedBox(),
                value: selectedCountry ?? countries.first,
                items: countries
                    .map((c) =>
                    DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) onCountrySelected(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
