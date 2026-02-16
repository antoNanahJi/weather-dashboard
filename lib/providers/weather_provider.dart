import 'package:flutter/foundation.dart';
import '../models/current_weather.dart';
import '../models/forecast_day.dart';
import '../services/weather_service.dart';
import '../services/storage_service.dart';

/// Provider for weather data state management
class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService;
  final StorageService _storageService;

  // State variables
  CurrentWeather? _currentWeather;
  List<ForecastDay> _forecast = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _lastSearchedCity;

  // Getters
  CurrentWeather? get currentWeather => _currentWeather;
  List<ForecastDay> get forecast => _forecast;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get lastSearchedCity => _lastSearchedCity;
  bool get hasData => _currentWeather != null;
  bool get hasError => _errorMessage != null;

  WeatherProvider({
    required WeatherService weatherService,
    required StorageService storageService,
  })  : _weatherService = weatherService,
        _storageService = storageService;

  /// Fetch weather data for a city
  ///
  /// Sets loading state, fetches data, and updates UI
  /// Saves successful searches to recent searches
  Future<void> fetchWeather(String city) async {
    if (city.trim().isEmpty) {
      _errorMessage = 'Please enter a city name';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Fetch current weather and forecast in parallel
      final results = await Future.wait([
        _weatherService.getCurrentWeather(city),
        _weatherService.getForecast(city),
      ]);

      _currentWeather = results[0] as CurrentWeather;
      _forecast = results[1] as List<ForecastDay>;
      _lastSearchedCity = city;
      _errorMessage = null;

      // Save to recent searches
      await _storageService.saveRecentSearch(city);

      _isLoading = false;
      notifyListeners();
    } on WeatherException catch (e) {
      _errorMessage = e.message;
      _currentWeather = null;
      _forecast = [];
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'An unexpected error occurred. Please try again.';
      _currentWeather = null;
      _forecast = [];
      _isLoading = false;
      notifyListeners();
      debugPrint('Error fetching weather: $e');
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Refresh current weather data
  Future<void> refresh() async {
    if (_lastSearchedCity != null) {
      await fetchWeather(_lastSearchedCity!);
    }
  }
}
