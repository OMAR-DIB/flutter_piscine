import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medium_weather_app_03/models/weather_models.dart';
import 'package:medium_weather_app_03/services/geocording_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medium_weather_app_03/services/weather_service.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class NavigationProvider extends ChangeNotifier {
  int selectedIndex = 0;
  final PageController pageController = PageController();

  // Stored selected location info
  String? cityName;
  String? region;
  String? country;
  double? latitude;
  double? longitude;
  String? globalError;
void setError(String message) {
  globalError = message;
  notifyListeners();
}
void clearError() {
  globalError = null;
  notifyListeners();
}

  // Weather
  CurrentWeatherModel? currentWeather;
  List<TodayHourlyModel> todayWeather = [];
  List<WeeklyDailyModel> weeklyWeather = [];

  // Suggestions
  List<dynamic> _citySuggestions = [];
  List<dynamic> get citySuggestions => _citySuggestions;

  // 📌 Change tab
  void updateBottomNavItemIndex(int index) {
    selectedIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  // 🔍 Search suggestions
  Future<void> searchCity(String query) async {
    _citySuggestions = await GeocodingService.searchCity(query);
    notifyListeners();
  }

  // 📌 Select city from suggestions
  Future<void> selectCitySuggestion(dynamic city) async {
    cityName = city["name"];
    region = city["admin1"] ?? "";
    country = city["country"];
    latitude = city["latitude"];
    longitude = city["longitude"];

    _citySuggestions = [];
    notifyListeners();

    await loadWeather();
  }

  // 📌 Clear selection
  void clearCity() {
    cityName = null;
    region = null;
    country = null;
    latitude = null;
    longitude = null;
    _citySuggestions = [];
    notifyListeners();
  }

  // 📍 GPS
  Future<void> getCurrentLocation() async {
    LocationPermission permission;

    // Check service
    bool isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) {
      globalError = "GPS service is disabled.";
      notifyListeners();
      return;
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        globalError = "Location permission denied.";
        notifyListeners();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setError("Enable location in settings.");
      notifyListeners();
      return;
    }

    // Allowed → Get coordinates
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude = pos.latitude;
    longitude =  pos.longitude;
    clearError();
    notifyListeners();
  }
  // 🌦️ Load weather after GPS or search
  Future<void> loadWeather() async {
  if (latitude == null || longitude == null) {
    setError("Invalid location");
    return;
  }

  try {
    final result = await WeatherService.fetchWeather(
      latitude!, longitude!, cityName!, region!, country!,
    );

    currentWeather = result["current"];
    todayWeather = result["today"];
    weeklyWeather = result["weekly"];

    clearError(); // 👈 remove error only when valid

  } catch (e) {
    setError("Connection issue. Please check your internet.");
  }
}
}
