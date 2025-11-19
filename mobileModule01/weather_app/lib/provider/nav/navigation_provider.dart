import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  /// Function to update the index of the selected bottom navigation bar item
  void updateBottomNavItemIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
