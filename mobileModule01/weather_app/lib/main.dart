



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/routes/app_routes.dart';
import 'package:weather_app/core/routes/routes_generator.dart';
import 'package:weather_app/core/themes/light_theme.dart';
import 'package:weather_app/provider/nav/navigation_provider.dart';

void main() {
  runApp(const Vivadoo());
}

class Vivadoo extends StatelessWidget {
  const Vivadoo({super.key});

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'vivadoo',
        theme: LightTheme.themeData,
        onGenerateRoute: RoutesGenerator.generateRoute,
        initialRoute: AppRoutes.home,
      ),
    );
  }
}