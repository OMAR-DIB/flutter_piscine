import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medium_weather_app_01/provider/nav/navigation_provider.dart';

class WeeklyScreen extends StatelessWidget {
  const WeeklyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NavigationProvider>();

  if (provider.errorMessage != null) {
    return Center(
      child: Text(
        provider.errorMessage!,
        style: const TextStyle(color: Colors.red, fontSize: 20),
      ),
    );
  }

    return Center(child: Text('Weekly ${context.watch<NavigationProvider>().text} , ${context.watch<NavigationProvider>().coordinates}'),);
  }
}