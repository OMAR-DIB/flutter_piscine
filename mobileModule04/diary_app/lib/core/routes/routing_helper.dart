import 'package:flutter/material.dart';
import 'package:diary_app/core/themes/light_theme.dart';


class RoutingHelper {
  // List of  screens

  static List<Widget> screens = [

  ];

  static NavigationDestination buildNavigationItem({
    required int index,
    required int currentIndex,
    required IconData icon,
    required String label,
    required BuildContext context,
  }) {
    bool isSelected = index == currentIndex;
    Color selectedColor = LightTheme.primaryColor;
    Color unselectedColor = LightTheme.disabledColor;

    return NavigationDestination(
      icon: Icon(icon, color: isSelected ? selectedColor : unselectedColor),
      label: label,
    );
  }
}
