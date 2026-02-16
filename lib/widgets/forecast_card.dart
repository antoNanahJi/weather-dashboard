import 'package:flutter/material.dart';
import '../models/forecast_day.dart';
import '../utils/formatters.dart';
import '../utils/constants.dart';

/// Widget for a single day's forecast
class ForecastCard extends StatelessWidget {
  final ForecastDay forecast;

  const ForecastCard({
    super.key,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Day name
            Text(
              WeatherFormatters.formatDayName(forecast.date),
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Weather icon emoji
            Text(
              AppConstants.getWeatherEmoji(forecast.iconCode),
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 8),

            // Temperature range
            Text(
              WeatherFormatters.formatTemperatureRange(
                forecast.minTemp,
                forecast.maxTemp,
              ),
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),

            // Description
            Text(
              WeatherFormatters.capitalizeWords(forecast.description),
              style: textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
