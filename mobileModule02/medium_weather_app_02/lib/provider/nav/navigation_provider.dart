import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medium_weather_app_02/models/weather_models.dart';
import 'package:medium_weather_app_02/services/geocording_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medium_weather_app_02/services/weather_service.dart';

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
  if (kIsWeb) {
    try {
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude = pos.latitude;
      longitude = pos.longitude;

      final results = await GeocodingService.searchCity(
        "${pos.latitude},${pos.longitude}",
      );

      if (results.isNotEmpty) {
        final city = results.first;
        cityName = city["name"];
        region = city["admin1"] ?? "";
        country = city["country"];
      }

      await loadWeather();
    } catch (e) {
      
      notifyListeners();
    }
    return;
  }

  // 👇 MOBILE CODE BELOW (unchanged)
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.deniedForever) return;

  Position pos = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  latitude = pos.latitude;
  longitude = pos.longitude;

  final results = await GeocodingService.searchCity(
    "${pos.latitude},${pos.longitude}",
  );

  if (results.isNotEmpty) {
    final city = results.first;
    cityName = city["name"];
    region = city["admin1"] ?? "";
    country = city["country"];
  }

  await loadWeather();
}

  // 🌦️ Load weather after GPS or search
  Future<void> loadWeather() async {
    if (latitude == null || longitude == null) return;

    final result = await WeatherService.fetchWeather(
      latitude!, longitude!, cityName!, region!, country!,
    );

    currentWeather = result["current"];
    todayWeather = result["today"];
    weeklyWeather = result["weekly"];

    notifyListeners();
  }
}
