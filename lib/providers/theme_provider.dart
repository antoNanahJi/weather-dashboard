import 'package:flutter/material.dart';
import '../services/storage_service.dart';

/// Provider for theme state management
class ThemeProvider with ChangeNotifier {
  final StorageService _storageService;
  bool _isDarkMode = false;

  /// Get current theme mode
  bool get isDarkMode => _isDarkMode;

  /// Get ThemeMode for MaterialApp
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider({required StorageService storageService})
      : _storageService = storageService {
    _loadThemePreference();
  }

  /// Load theme preference from storage
  void _loadThemePreference() {
    _isDarkMode = _storageService.getThemeMode();
    notifyListeners();
  }

  /// Toggle between light and dark mode
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _storageService.saveThemeMode(_isDarkMode);
    notifyListeners();
  }

  /// Set specific theme mode
  Future<void> setThemeMode(bool isDark) async {
    if (_isDarkMode == isDark) return;

    _isDarkMode = isDark;
    await _storageService.saveThemeMode(_isDarkMode);
    notifyListeners();
  }
}
