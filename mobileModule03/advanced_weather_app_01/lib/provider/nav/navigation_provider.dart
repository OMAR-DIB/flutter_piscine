import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:advanced_weather_app_01/models/weather_models.dart';
import 'package:advanced_weather_app_01/services/geocording_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:advanced_weather_app_01/services/weather_service.dart';

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
static Future<Map<String, dynamic>?> ipFallback() async {
  try {
    final url = Uri.parse("https://ipapi.co/json/");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json["latitude"] != null && json["longitude"] != null) {
        return {
          "name": json["city"],
          "admin1": json["region"],
          "country": json["country_name"],
          "latitude": json["latitude"],
          "longitude": json["longitude"],
        };
      }
    }
  } catch (e) {
    // CORS or network error
  }
  return null;
}

static Future<Map<String, dynamic>?> reverseGeocode(double lat, double lon) async {
  try {
    final url = Uri.parse(
      "https://geocoding-api.open-meteo.com/v1/reverse?latitude=$lat&longitude=$lon&count=1&language=en&format=json"
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json["results"] != null && json["results"].isNotEmpty) {
        return json["results"][0]; // first result
      }
    }
  } catch (e) {
    // CORS or network error
  }
  return null;
}


  // 📍 GPS
Future<void> getCurrentLocation() async {
  LocationPermission permission;

  // Check service
  bool isEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isEnabled) {
    setError("GPS service is disabled.");
    return;
  }

  // Check permission
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      setError("Location permission denied.");
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    setError("Enable location in settings.");
    return;
  }

  // Get coordinates
  Position pos = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  latitude = pos.latitude;
  longitude = pos.longitude;

  // Reverse Geocode to detect city name
  var result = await reverseGeocode(pos.latitude, pos.longitude);

// ❗ If reverse fails -> Try IP fallback
if (result == null) {
  result = await ipFallback();
}


  if (result != null) {
    cityName = result["name"];
    region = result["admin1"] ?? "";
    country = result["country"] ?? "";
  } else {
    // Use default name if reverse geocoding fails (e.g., CORS on web)
    cityName = "Current Location";
    region = "";
    country = "";
  }
  notifyListeners(); // Update UI with location info

  // Load weather
  await loadWeather();

  clearError();
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
