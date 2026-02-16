import 'package:flutter/material.dart';
import '../models/current_weather.dart';
import '../utils/formatters.dart';
import '../utils/constants.dart';

/// Widget to display current weather information
class CurrentWeatherCard extends StatelessWidget {
  final CurrentWeather weather;

  const CurrentWeatherCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 4,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _getGradientColors(weather.iconCode),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // City and Country
              Text(
                '${weather.city}, ${weather.country}',
                style: textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Date
              Text(
                WeatherFormatters.formatFullDate(weather.dateTime),
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 24),

              // Weather Icon and Description
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppConstants.getWeatherEmoji(weather.iconCode),
                    style: const TextStyle(fontSize: 64),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Temperature
                      Text(
                        WeatherFormatters.formatTemperature(weather.temperature),
                        style: textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 56,
                        ),
                      ),
                      // Feels Like
                      Text(
                        '${AppConstants.feelsLikeLabel} ${WeatherFormatters.formatTemperature(weather.feelsLike)}',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                WeatherFormatters.capitalizeWords(weather.description),
                style: textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),

              // Additional Info Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Humidity
                  _InfoTile(
                    icon: Icons.water_drop,
                    label: AppConstants.humidityLabel,
                    value: WeatherFormatters.formatHumidity(weather.humidity),
                  ),
                  // Wind Speed
                  _InfoTile(
                    icon: Icons.air,
                    label: AppConstants.windSpeedLabel,
                    value: WeatherFormatters.formatWindSpeed(weather.windSpeed),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Get gradient colors based on weather condition
  List<Color> _getGradientColors(String iconCode) {
    if (iconCode.contains('01')) {
      // Clear sky
      return iconCode.endsWith('d')
          ? [Colors.blue.shade400, Colors.blue.shade600]
          : [Colors.indigo.shade800, Colors.indigo.shade900];
    } else if (iconCode.contains('02') || iconCode.contains('03')) {
      // Few/scattered clouds
      return [Colors.blueGrey.shade400, Colors.blueGrey.shade600];
    } else if (iconCode.contains('04')) {
      // Broken clouds
      return [Colors.grey.shade600, Colors.grey.shade800];
    } else if (iconCode.contains('09') ||
        iconCode.contains('10') ||
        iconCode.contains('11')) {
      // Rain/thunderstorm
      return [Colors.indigo.shade600, Colors.indigo.shade800];
    } else if (iconCode.contains('13')) {
      // Snow
      return [Colors.lightBlue.shade300, Colors.lightBlue.shade500];
    } else {
      // Default
      return [Colors.blue.shade400, Colors.blue.shade600];
    }
  }
}

/// Small info tile for humidity and wind speed
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
