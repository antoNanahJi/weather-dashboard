import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// Widget to display recent searches with chips
class RecentSearches extends StatelessWidget {
  final List<String> cities;
  final Function(String) onCityTap;
  final VoidCallback onClear;

  const RecentSearches({
    super.key,
    required this.cities,
    required this.onCityTap,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    if (cities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppConstants.recentSearchesLabel,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton.icon(
                onPressed: onClear,
                icon: const Icon(Icons.clear_all, size: 16),
                label: const Text(AppConstants.clearButton),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cities
                .map(
                  (city) => ActionChip(
                    label: Text(city),
                    avatar: const Icon(Icons.location_city, size: 16),
                    onPressed: () => onCityTap(city),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
