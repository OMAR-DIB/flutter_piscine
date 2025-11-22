import 'package:flutter/material.dart';
import 'package:advanced_weather_app_02/core/routes/error_route.dart';
import 'package:advanced_weather_app_02/core/widgets/navigations_menu.dart';

import 'app_routes.dart';

class RoutesGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) =>  NavigationMenu(),
        );
      default:
        return errorRoute(settings);
    }
  }
}