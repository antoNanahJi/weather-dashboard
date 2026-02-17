/// Application constants
class AppConstants {
  // App Info
  static const String appName = 'Weather Dashboard';

  // Storage
  static const int maxRecentSearches = 10;

  // Error Messages
  static const String genericErrorMessage =
      'Something went wrong. Please try again.';
  static const String noInternetMessage =
      'No internet connection. Please check your network settings.';
  static const String cityNotFoundMessage =
      'City not found. Please check the city name and try again.';
  static const String invalidApiKeyMessage =
      'Invalid API key. Please check your configuration.';

  // UI Strings
  static const String searchHint = 'Enter city name...';
  static const String searchButton = 'Search';
  static const String retryButton = 'Retry';
  static const String clearButton = 'Clear All';
  static const String recentSearchesLabel = 'Recent Searches';
  static const String forecastLabel = '7-Day Forecast';
  static const String feelsLikeLabel = 'Feels like';
  static const String humidityLabel = 'Humidity';
  static const String windSpeedLabel = 'Wind Speed';
  static const String noDataMessage = 'Search for a city to see the weather';

  // Weather Icon Mapping (OpenWeather icon codes to emoji/description)
  static const Map<String, String> weatherIconEmoji = {
    '01d': '☀️', // clear sky day
    '01n': '🌙', // clear sky night
    '02d': '⛅', // few clouds day
    '02n': '☁️', // few clouds night
    '03d': '☁️', // scattered clouds
    '03n': '☁️',
    '04d': '☁️', // broken clouds
    '04n': '☁️',
    '09d': '🌧️', // shower rain
    '09n': '🌧️',
    '10d': '🌦️', // rain day
    '10n': '🌧️', // rain night
    '11d': '⛈️', // thunderstorm
    '11n': '⛈️',
    '13d': '❄️', // snow
    '13n': '❄️',
    '50d': '🌫️', // mist
    '50n': '🌫️',
  };

  /// Get emoji for weather icon code
  static String getWeatherEmoji(String iconCode) {
    return weatherIconEmoji[iconCode] ?? '🌤️';
  }
}
