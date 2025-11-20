import 'package:flutter/material.dart';

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
}
