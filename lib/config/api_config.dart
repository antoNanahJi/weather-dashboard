/// API configuration for Open-Meteo (Free Weather API)
/// No API key required! Completely free and open source.
class ApiConfig {
  // Base URLs
  static const String geocodingBaseUrl = 'https://geocoding-api.open-meteo.com/v1';
  static const String weatherBaseUrl = 'https://api.open-meteo.com/v1';

  // Temperature unit (celsius or fahrenheit)
  static const String temperatureUnit = 'celsius';

  // Wind speed unit (kmh, ms, mph, kn)
  static const String windSpeedUnit = 'kmh';

  /// Build URL for geocoding (city name to coordinates)
  static String getGeocodingUrl(String city) {
    return '$geocodingBaseUrl/search?name=${Uri.encodeComponent(city)}&count=1&language=en&format=json';
  }

  /// Build URL for current weather
  static String getCurrentWeatherUrl(double latitude, double longitude) {
    return '$weatherBaseUrl/forecast?'
        'latitude=$latitude&'
        'longitude=$longitude&'
        'current=temperature_2m,relative_humidity_2m,apparent_temperature,'
        'weather_code,wind_speed_10m&'
        'temperature_unit=$temperatureUnit&'
        'wind_speed_unit=$windSpeedUnit&'
        'timezone=auto';
  }

  /// Build URL for forecast (7 days)
  static String getForecastUrl(double latitude, double longitude) {
    return '$weatherBaseUrl/forecast?'
        'latitude=$latitude&'
        'longitude=$longitude&'
        'daily=weather_code,temperature_2m_max,temperature_2m_min,'
        'apparent_temperature_max,apparent_temperature_min&'
        'temperature_unit=$temperatureUnit&'
        'wind_speed_unit=$windSpeedUnit&'
        'timezone=auto';
  }

  /// Get weather description from WMO weather code
  /// https://open-meteo.com/en/docs
  static String getWeatherDescription(int code) {
    switch (code) {
      case 0:
        return 'clear sky';
      case 1:
      case 2:
      case 3:
        return 'partly cloudy';
      case 45:
      case 48:
        return 'foggy';
      case 51:
      case 53:
      case 55:
        return 'drizzle';
      case 61:
      case 63:
      case 65:
        return 'rain';
      case 66:
      case 67:
        return 'freezing rain';
      case 71:
      case 73:
      case 75:
        return 'snow';
      case 77:
        return 'snow grains';
      case 80:
      case 81:
      case 82:
        return 'rain showers';
      case 85:
      case 86:
        return 'snow showers';
      case 95:
        return 'thunderstorm';
      case 96:
      case 99:
        return 'thunderstorm with hail';
      default:
        return 'unknown';
    }
  }

  /// Get weather icon code from WMO weather code
  static String getWeatherIconCode(int code, bool isDay) {
    final dayNight = isDay ? 'd' : 'n';

    if (code == 0) return '01$dayNight'; // Clear sky
    if (code >= 1 && code <= 3) return '02$dayNight'; // Partly cloudy
    if (code >= 45 && code <= 48) return '50$dayNight'; // Fog
    if (code >= 51 && code <= 55) return '09$dayNight'; // Drizzle
    if (code >= 61 && code <= 67) return '10$dayNight'; // Rain
    if (code >= 71 && code <= 77) return '13$dayNight'; // Snow
    if (code >= 80 && code <= 82) return '09$dayNight'; // Rain showers
    if (code >= 85 && code <= 86) return '13$dayNight'; // Snow showers
    if (code >= 95 && code <= 99) return '11$dayNight'; // Thunderstorm

    return '01$dayNight'; // Default
  }
}
