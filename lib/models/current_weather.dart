import '../config/api_config.dart';

/// Model class for current weather data
class CurrentWeather {
  final String city;
  final String country;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String description;
  final String iconCode;
  final DateTime dateTime;

  CurrentWeather({
    required this.city,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.iconCode,
    required this.dateTime,
  });

  /// Create CurrentWeather from Open-Meteo API response
  factory CurrentWeather.fromOpenMeteo({
    required Map<String, dynamic> weatherData,
    required String cityName,
    required String countryCode,
  }) {
    final current = weatherData['current'] as Map<String, dynamic>;
    final weatherCode = current['weather_code'] as int;
    final isDay = (current['is_day'] as int?) == 1;

    return CurrentWeather(
      city: cityName,
      country: countryCode,
      temperature: (current['temperature_2m'] as num).toDouble(),
      feelsLike: (current['apparent_temperature'] as num).toDouble(),
      humidity: (current['relative_humidity_2m'] as num).toInt(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      description: ApiConfig.getWeatherDescription(weatherCode),
      iconCode: ApiConfig.getWeatherIconCode(weatherCode, isDay),
      dateTime: DateTime.parse(current['time'] as String),
    );
  }

  /// Convert CurrentWeather to JSON (for potential caching/storage)
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
      'temperature': temperature,
      'feelsLike': feelsLike,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'description': description,
      'iconCode': iconCode,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  /// Create CurrentWeather from JSON
  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      city: json['city'] as String,
      country: json['country'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      feelsLike: (json['feelsLike'] as num).toDouble(),
      humidity: json['humidity'] as int,
      windSpeed: (json['windSpeed'] as num).toDouble(),
      description: json['description'] as String,
      iconCode: json['iconCode'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
    );
  }

  @override
  String toString() {
    return 'CurrentWeather(city: $city, temp: $temperature°C, description: $description)';
  }
}
