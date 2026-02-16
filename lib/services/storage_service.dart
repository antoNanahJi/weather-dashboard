import 'package:shared_preferences/shared_preferences.dart';

/// Service class for local data storage using SharedPreferences
class StorageService {
  static const String _recentSearchesKey = 'recent_searches';
  static const String _themeModeKey = 'is_dark_mode';
  static const int _maxRecentSearches = 10;

  final SharedPreferences _prefs;

  StorageService._(this._prefs);

  /// Initialize StorageService
  ///
  /// Must be called before using the service
  static Future<StorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService._(prefs);
  }

  /// Save a city to recent searches
  ///
  /// Adds the city to the beginning of the list and maintains max 10 entries
  /// Removes duplicates (case-insensitive)
  Future<void> saveRecentSearch(String city) async {
    final searches = getRecentSearches();

    // Remove existing entry (case-insensitive) to avoid duplicates
    searches.removeWhere(
      (s) => s.toLowerCase() == city.toLowerCase(),
    );

    // Add to beginning
    searches.insert(0, city);

    // Keep only max entries
    if (searches.length > _maxRecentSearches) {
      searches.removeRange(_maxRecentSearches, searches.length);
    }

    await _prefs.setStringList(_recentSearchesKey, searches);
  }

  /// Get list of recent searches
  ///
  /// Returns empty list if no searches saved
  List<String> getRecentSearches() {
    return _prefs.getStringList(_recentSearchesKey) ?? [];
  }

  /// Clear all recent searches
  Future<void> clearRecentSearches() async {
    await _prefs.remove(_recentSearchesKey);
  }

  /// Save theme mode preference
  ///
  /// [isDark] - true for dark mode, false for light mode
  Future<void> saveThemeMode(bool isDark) async {
    await _prefs.setBool(_themeModeKey, isDark);
  }

  /// Get saved theme mode preference
  ///
  /// Returns false (light mode) if no preference saved
  bool getThemeMode() {
    return _prefs.getBool(_themeModeKey) ?? false;
  }
}
