import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';
import '../widgets/search_bar.dart';
import '../widgets/loading_spinner.dart';
import '../widgets/error_message.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/forecast_list.dart';
import '../widgets/recent_searches.dart';
import '../widgets/theme_toggle.dart';

/// Main home screen for the weather dashboard
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _recentSearches = [];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  /// Load recent searches from storage
  Future<void> _loadRecentSearches() async {
    final storageService = context.read<StorageService>();
    setState(() {
      _recentSearches = storageService.getRecentSearches();
    });
  }

  /// Handle city search
  Future<void> _handleSearch(String city) async {
    await context.read<WeatherProvider>().fetchWeather(city);
    _loadRecentSearches(); // Reload recent searches after new search
  }

  /// Handle retry after error
  void _handleRetry() {
    final weatherProvider = context.read<WeatherProvider>();
    if (weatherProvider.lastSearchedCity != null) {
      weatherProvider.fetchWeather(weatherProvider.lastSearchedCity!);
    }
  }

  /// Handle clear recent searches
  Future<void> _handleClearSearches() async {
    final storageService = context.read<StorageService>();
    await storageService.clearRecentSearches();
    _loadRecentSearches();
  }

  /// Handle pull to refresh
  Future<void> _handleRefresh() async {
    await context.read<WeatherProvider>().refresh();
    await _loadRecentSearches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: const [
          ThemeToggle(),
          SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Bar
              CitySearchBar(onSearch: _handleSearch),
              const SizedBox(height: 24),

              // Recent Searches (if any)
              if (_recentSearches.isNotEmpty) ...[
                RecentSearches(
                  cities: _recentSearches,
                  onCityTap: _handleSearch,
                  onClear: _handleClearSearches,
                ),
                const SizedBox(height: 24),
              ],

              // Weather Content
              Consumer<WeatherProvider>(
                builder: (context, weatherProvider, child) {
                  // Loading state
                  if (weatherProvider.isLoading) {
                    return const SizedBox(
                      height: 400,
                      child: LoadingSpinner(),
                    );
                  }

                  // Error state
                  if (weatherProvider.hasError) {
                    return ErrorMessage(
                      message: weatherProvider.errorMessage!,
                      onRetry: _handleRetry,
                    );
                  }

                  // Data loaded state
                  if (weatherProvider.hasData) {
                    return Column(
                      children: [
                        // Current Weather Card (Centered)
                        Center(
                          child: CurrentWeatherCard(
                            weather: weatherProvider.currentWeather!,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // 7-Day Forecast
                        ForecastList(
                          forecasts: weatherProvider.forecast,
                        ),
                      ],
                    );
                  }

                  // Empty state (no data yet)
                  return SizedBox(
                    height: 400,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wb_sunny_outlined,
                            size: 80,
                            color: Theme.of(context)
                                .iconTheme
                                .color
                                ?.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppConstants.noDataMessage,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
