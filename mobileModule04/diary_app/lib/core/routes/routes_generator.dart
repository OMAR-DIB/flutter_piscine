import 'package:diary_app/features/auth/auth_wrapper.dart';
import 'package:diary_app/features/login/login_screen.dart';
import 'package:diary_app/features/splash/Splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:diary_app/core/routes/error_route.dart';
import 'app_routes.dart';

class RoutesGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) =>  SplashScreen(),
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) =>  LoginScreen(),
        );
      case AppRoutes.redirect:
        return MaterialPageRoute(
          builder: (_) =>  AuthWrapper(),
        );
      default:
        return errorRoute(settings);
    }
  }
}