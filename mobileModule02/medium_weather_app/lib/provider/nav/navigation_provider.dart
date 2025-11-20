import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  final PageController pageController = PageController();
  /// Function to update the index of the selected bottom navigation bar item
  
   void updateBottomNavItemIndex(int index) {
    _selectedIndex = index;
    pageController.jumpToPage(index); // 👈 Sync with PageView
    notifyListeners();
  }

  String _text = "";

  String get text => _text;

  void updateContent(String newText)
  {
    _text = newText;
    notifyListeners();
  }

    /// 🌍 GPS PART
  // String? coordinates;
  String? errorMessage;

  Future<void> getCurrentLocation() async {
    LocationPermission permission;

    // Check service
    bool isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) {
      errorMessage = "GPS service is disabled.";
      notifyListeners();
      return;
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        errorMessage = "Location permission denied.";
        notifyListeners();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      errorMessage = "Enable location in settings.";
      notifyListeners();
      return;
    }

    // Allowed → Get coordinates
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _text = "${pos.latitude}, ${pos.longitude}";
    errorMessage = null;
    notifyListeners();
  }
}
