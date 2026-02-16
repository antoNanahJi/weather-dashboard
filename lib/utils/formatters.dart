import 'package:intl/intl.dart';

/// Utility class for formatting weather data
class WeatherFormatters {
  /// Format temperature to display with degree symbol
  ///
  /// Example: 25.5 → "26°C"
  static String formatTemperature(double temperature) {
    return '${temperature.round()}°C';
  }

  /// Format temperature range (min/max)
  ///
  /// Example: (18.2, 25.7) → "18° / 26°"
  static String formatTemperatureRange(double min, double max) {
    return '${min.round()}° / ${max.round()}°';
  }

  /// Format date to display day name
  ///
  /// Example: DateTime(2024, 1, 15) → "Mon"
  static String formatDayName(DateTime date) {
    return DateFormat('EEE').format(date);
  }

  /// Format date to full format
  ///
  /// Example: DateTime(2024, 1, 15) → "Mon, Jan 15"
  static String formatFullDate(DateTime date) {
    return DateFormat('EEE, MMM d').format(date);
  }

  /// Format wind speed
  ///
  /// Example: 12.5 → "13 km/h"
  static String formatWindSpeed(double speed) {
    // Convert m/s to km/h
    final kmh = speed * 3.6;
    return '${kmh.round()} km/h';
  }

  /// Format humidity percentage
  ///
  /// Example: 65 → "65%"
  static String formatHumidity(int humidity) {
    return '$humidity%';
  }

  /// Capitalize first letter of each word
  ///
  /// Example: "clear sky" → "Clear Sky"
  static String capitalizeWords(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }
}
