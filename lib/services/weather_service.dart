import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/current_weather.dart';
import '../models/forecast_day.dart';

/// Service class for fetching weather data from Open-Meteo API (Free!)
class WeatherService {
  final Dio _dio;

  WeatherService()
      : _dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        );

  /// Fetch current weather for a city
  ///
  /// Throws [WeatherException] if the request fails
  Future<CurrentWeather> getCurrentWeather(String city) async {
    try {
      // Step 1: Get coordinates from city name (geocoding)
      final location = await _getLocationCoordinates(city);

      // Step 2: Fetch weather data using coordinates
      final url = ApiConfig.getCurrentWeatherUrl(
        location['latitude']!,
        location['longitude']!,
      );
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return CurrentWeather.fromOpenMeteo(
          weatherData: response.data,
          cityName: location['name']!,
          countryCode: location['country']!,
        );
      } else {
        throw WeatherException(
          'Failed to fetch weather data: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      if (e is WeatherException) rethrow;
      throw WeatherException('Unexpected error: $e');
    }
  }

  /// Fetch 7-day forecast for a city
  ///
  /// Returns a list of daily forecast data (7 days)
  /// Throws [WeatherException] if the request fails
  Future<List<ForecastDay>> getForecast(String city) async {
    try {
      // Step 1: Get coordinates from city name (geocoding)
      final location = await _getLocationCoordinates(city);

      // Step 2: Fetch forecast data using coordinates
      final url = ApiConfig.getForecastUrl(
        location['latitude']!,
        location['longitude']!,
      );
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return _parseForecastData(response.data);
      } else {
        throw WeatherException(
          'Failed to fetch forecast data: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      if (e is WeatherException) rethrow;
      throw WeatherException('Unexpected error: $e');
    }
  }

  /// Get location coordinates from city name using geocoding API
  ///
  /// Returns map with latitude, longitude, name, and country
  Future<Map<String, dynamic>> _getLocationCoordinates(String city) async {
    final url = ApiConfig.getGeocodingUrl(city);
    final response = await _dio.get(url);

    if (response.statusCode == 200) {
      final data = response.data;

      // Check if results array exists and is not empty
      if (data['results'] == null || (data['results'] as List).isEmpty) {
        throw WeatherException(
          'City not found. Please check the city name and try again.',
        );
      }

      final location = data['results'][0];
      return {
        'latitude': location['latitude'] as double,
        'longitude': location['longitude'] as double,
        'name': location['name'] as String,
        'country': location['country_code'] as String? ?? 'Unknown',
      };
    } else {
      throw WeatherException(
        'Failed to geocode city: ${response.statusMessage}',
      );
    }
  }

  /// Parse forecast data from Open-Meteo API response
  ///
  /// Extracts daily forecasts (5 days)
  List<ForecastDay> _parseForecastData(Map<String, dynamic> data) {
    final daily = data['daily'] as Map<String, dynamic>;

    final dates = daily['time'] as List;
    final maxTemps = daily['temperature_2m_max'] as List;
    final minTemps = daily['temperature_2m_min'] as List;
    final weatherCodes = daily['weather_code'] as List;

    final List<ForecastDay> forecasts = [];

    // Get 7 days of forecast (skip today, get next 7 days)
    const startIndex = 1; // Skip today (index 0)
    final endIndex = (startIndex + 7).clamp(0, dates.length);

    for (var i = startIndex; i < endIndex; i++) {
      forecasts.add(
        ForecastDay.fromOpenMeteo(
          dateStr: dates[i] as String,
          minTemp: (minTemps[i] as num).toDouble(),
          maxTemp: (maxTemps[i] as num).toDouble(),
          weatherCode: weatherCodes[i] as int,
        ),
      );
    }

    return forecasts;
  }

  /// Handle Dio errors and convert to WeatherException
  WeatherException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return WeatherException(
          'Connection timeout. Please check your internet connection.',
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 404) {
          return WeatherException(
            'City not found. Please check the city name and try again.',
          );
        } else {
          return WeatherException(
            'Server error ($statusCode). Please try again later.',
          );
        }

      case DioExceptionType.cancel:
        return WeatherException('Request was cancelled.');

      case DioExceptionType.connectionError:
        return WeatherException(
          'No internet connection. Please check your network settings.',
        );

      default:
        return WeatherException('Network error: ${error.message}');
    }
  }
}

/// Custom exception for weather-related errors
class WeatherException implements Exception {
  final String message;

  WeatherException(this.message);

  @override
  String toString() => message;
}
