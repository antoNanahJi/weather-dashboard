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
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _getGradientColors(weather.iconCode),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SizedBox(
            height: 80,
            child: Stack(
              children: [
                // Left section: City, Date & Description
                Positioned(
                  left: 0,
                  top: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${weather.city}, ${weather.country}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        WeatherFormatters.formatFullDate(weather.dateTime),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        WeatherFormatters.capitalizeWords(weather.description),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Centered Temperature Section
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppConstants.getWeatherEmoji(weather.iconCode),
                        style: const TextStyle(fontSize: 40),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            WeatherFormatters.formatTemperature(weather.temperature),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${AppConstants.feelsLikeLabel} ${WeatherFormatters.formatTemperature(weather.feelsLike)}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Right section: Weather Info
                Positioned(
                  right: 0,
                  top: 0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _InfoTileCompact(
                        icon: Icons.water_drop,
                        label: AppConstants.humidityLabel,
                        value: WeatherFormatters.formatHumidity(weather.humidity),
                      ),
                      const SizedBox(width: 16),
                      _InfoTileCompact(
                        icon: Icons.air,
                        label: AppConstants.windSpeedLabel,
                        value: WeatherFormatters.formatWindSpeed(weather.windSpeed),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

/// Compact info tile for humidity and wind speed
class _InfoTileCompact extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTileCompact({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
