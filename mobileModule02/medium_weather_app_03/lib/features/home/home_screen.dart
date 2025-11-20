import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medium_weather_app_03/provider/nav/navigation_provider.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NavigationProvider>();

  if (provider.globalError != null) {
    return Center(
      child: Text(
        provider.globalError!,
        style: const TextStyle(color: Colors.red, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }

  // 👇 Current logic if no error
  if (provider.currentWeather == null) {
    return const Center(child: Text("Search or use GPS"));
  }

    final w = provider.currentWeather!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${w.region}\n${w.country}", textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Text("${w.temperature}°C", style: const TextStyle(fontSize: 26)),
        Text(w.description),
        Text("${w.windSpeed} km/h Wind"),
      ],
    );
  }
}
