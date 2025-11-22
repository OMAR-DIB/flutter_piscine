import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void updateBottomNavItemIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
