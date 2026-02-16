# Weather Dashboard

A beautiful and responsive weather dashboard mobile application built with Flutter and Dart. Get real-time weather information and 5-day forecasts for any city worldwide using **completely free** Open-Meteo API!

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## ✨ Features

- 🔍 **City Search** - Search for weather by city name
- 🌡️ **Current Weather** - Display temperature, feels like, humidity, wind speed, and conditions
- 📅 **5-Day Forecast** - View daily weather forecasts with min/max temperatures
- 📱 **Responsive Design** - Optimized for both Android and iOS devices
- 💾 **Recent Searches** - Save and quickly access your recent city searches (up to 10)
- 🌓 **Dark/Light Mode** - Toggle between dark and light themes with persistent preference
- 🔄 **Pull to Refresh** - Refresh weather data with a simple pull gesture
- ⚡ **Fast & Smooth** - Built with Flutter for native performance
- 🆓 **Completely Free** - Uses Open-Meteo API - no API key required!

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.0 or higher)
- [Dart SDK](https://dart.dev/get-dart) (version 3.0 or higher)
- Android Studio or Xcode (for running on emulators/simulators)
- A code editor (VS Code, Android Studio, or IntelliJ IDEA)

### Installation

1. **Clone the repository**

```bash
git clone https://github.com/yourusername/weather-dashboard.git
cd weather-dashboard
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Verify Flutter setup**

```bash
flutter doctor
```

Make sure all required dependencies are installed and configured.

4. **Run the app**

For Android:
```bash
flutter run
```

For iOS (macOS only):
```bash
flutter run -d ios
```

For a specific device:
```bash
# List available devices
flutter devices

# Run on a specific device
flutter run -d <device_id>
```

That's it! **No API key needed** - the app uses the free Open-Meteo API! 🎉

## 📱 Supported Platforms

- ✅ Android (5.0 and above)
- ✅ iOS (11.0 and above)

## 🏗️ Project Structure

```
weather_dashboard/
├── lib/
│   ├── config/              # API configuration
│   ├── models/              # Data models (CurrentWeather, ForecastDay)
│   ├── providers/           # State management (Provider pattern)
│   ├── screens/             # UI screens (HomeScreen)
│   ├── services/            # API and storage services
│   ├── theme/               # Theme configuration (light/dark)
│   ├── utils/               # Utilities and constants
│   ├── widgets/             # Reusable UI components
│   └── main.dart            # App entry point
├── android/                 # Android-specific files
├── ios/                     # iOS-specific files
├── pubspec.yaml             # Flutter dependencies
└── README.md
```

## 🛠️ Tech Stack

### Core Technologies
- **Flutter** - UI framework for building natively compiled applications
- **Dart** - Programming language

### State Management
- **Provider** - Simple and scalable state management solution

### HTTP & Networking
- **Dio** - Powerful HTTP client with interceptors and error handling

### Local Storage
- **SharedPreferences** - Persistent key-value storage for recent searches and theme preference

### Utilities
- **intl** - Internationalization and date formatting

### API
- **Open-Meteo API** - Free, open-source weather API (no API key required!)

## 📖 How It Works

1. **User Input**: User enters a city name in the search bar
2. **Geocoding**: App converts city name to coordinates using Open-Meteo's geocoding API
3. **Weather Request**: App fetches weather data using coordinates
4. **Data Processing**:
   - Current weather data is parsed into CurrentWeather model
   - Forecast data (7 days) is extracted and limited to 5 days
   - Weather codes are converted to descriptions and icons
5. **State Update**: WeatherProvider updates app state and notifies UI
6. **UI Rendering**: Flutter rebuilds UI with new weather data
7. **Persistence**: City name is saved to recent searches in SharedPreferences

## 🎨 Features Details

### Current Weather Display
- City name and country code
- Current date and time
- Large temperature display
- "Feels like" temperature
- Weather condition description with emoji
- Humidity percentage
- Wind speed (km/h)
- Beautiful gradient background based on weather condition

### 5-Day Forecast
- Horizontal scrollable list
- Day name
- Weather emoji icon
- Min/max temperature range
- Weather description

### Recent Searches
- Display up to 10 recent city searches
- Click any chip to quickly search again
- "Clear All" button to remove history
- Automatically saves after successful search

### Dark/Light Mode
- Toggle button in app bar
- Persistent preference across app restarts
- Smooth transitions between themes
- Optimized colors for both modes

## 🔧 Configuration

### API Configuration

Edit `lib/config/api_config.dart` to change API settings:

```dart
static const String temperatureUnit = 'celsius'; // Change to 'fahrenheit' for Fahrenheit
static const String windSpeedUnit = 'kmh'; // Options: 'kmh', 'ms', 'mph', 'kn'
```

### Theme Customization

Edit theme files in `lib/theme/`:
- `colors.dart` - Color palette for light and dark modes
- `app_theme.dart` - Complete theme configuration

## 🧪 Building for Release

### Android (APK)

```bash
flutter build apk --release
```

The APK file will be located at: `build/app/outputs/flutter-apk/app-release.apk`

### Android (App Bundle for Google Play)

```bash
flutter build appbundle --release
```

### iOS (macOS only)

```bash
flutter build ios --release
```

## 🐛 Troubleshooting

### Common Issues

**1. Flutter not found**
- Ensure Flutter is installed and added to your PATH
- Run `flutter doctor` to verify installation

**2. No devices found**
- For Android: Start an emulator or connect a physical device
- For iOS: Open Xcode Simulator
- Run `flutter devices` to see available devices

**3. Build fails**
- Run `flutter clean`
- Run `flutter pub get`
- Try building again

**4. City not found error**
- Check city spelling
- Try using different city name variations
- Some small cities might not be in the geocoding database

## 🌟 Why Open-Meteo?

This app uses **Open-Meteo** instead of other weather APIs because:

- ✅ **Completely Free** - No API key required
- ✅ **No Rate Limits** - Unlimited requests
- ✅ **No Registration** - Start using immediately  
- ✅ **High Quality Data** - Uses official weather models (NOAA, DWD, Météo-France)
- ✅ **Open Source** - Community-driven project
- ✅ **Privacy Friendly** - No tracking or data collection
- ✅ **Fast & Reliable** - Global CDN with 99.9% uptime

## 📄 License

This project is licensed under the MIT License.

## 👤 Author

Anto Nanah Ji- [@antoNanahJi](https://github.com/yourusername)

## 🙏 Acknowledgments

- [Open-Meteo](https://open-meteo.com/) for the free weather API
- [Flutter](https://flutter.dev/) for the amazing framework
- Weather icons and emoji from system defaults
