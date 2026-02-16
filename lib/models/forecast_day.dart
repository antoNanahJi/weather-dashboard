import '../config/api_config.dart';

/// Model class for a single day's forecast
class ForecastDay {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final String description;
  final String iconCode;
  final int humidity;
  final double windSpeed;

  ForecastDay({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
  });

  /// Create ForecastDay from Open-Meteo daily forecast data
  factory ForecastDay.fromOpenMeteo({
    required String dateStr,
    required double minTemp,
    required double maxTemp,
    required int weatherCode,
  }) {
    return ForecastDay(
      date: DateTime.parse(dateStr),
      minTemp: minTemp,
      maxTemp: maxTemp,
      description: ApiConfig.getWeatherDescription(weatherCode),
      iconCode: ApiConfig.getWeatherIconCode(weatherCode, true), // Use day icon
      humidity: 0, // Not available in daily forecast
      windSpeed: 0, // Not available in daily forecast
    );
  }

  @override
  String toString() {
    return 'ForecastDay(date: $date, min: $minTemp°C, max: $maxTemp°C, desc: $description)';
  }
}
