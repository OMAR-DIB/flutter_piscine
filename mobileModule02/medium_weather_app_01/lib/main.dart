import 'package:flutter/material.dart';
import 'package:medium_weather_app_01/core/routes/app_routes.dart';
import 'package:medium_weather_app_01/core/routes/routes_generator.dart';
import 'package:medium_weather_app_01/core/themes/light_theme.dart';
import 'package:medium_weather_app_01/provider/nav/navigation_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'medium_weather_app',
        theme: LightTheme.themeData,
        onGenerateRoute: RoutesGenerator.generateRoute,
        initialRoute: AppRoutes.home,
      ),
    );
  }
}