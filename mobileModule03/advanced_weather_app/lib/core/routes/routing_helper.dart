import 'package:flutter/material.dart';
import 'package:advanced_weather_app/core/themes/light_theme.dart';
import 'package:advanced_weather_app/features/home/home_screen.dart';
import 'package:advanced_weather_app/features/second_page/second_page_screen.dart';
import 'package:advanced_weather_app/features/weekly/weekly_screen.dart';

class RoutingHelper {
  // List of  screens

  static List<Widget> screens = [
    HomeScreen(),
    SecondPageScreen(),
    WeeklyScreen()
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
