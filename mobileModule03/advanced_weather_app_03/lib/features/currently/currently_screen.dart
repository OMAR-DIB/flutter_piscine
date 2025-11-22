import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:advanced_weather_app_03/provider/nav/navigation_provider.dart';

class CurrentlyScreen extends StatelessWidget {
  const CurrentlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NavigationProvider>();

    // ❌ SHOW ERROR IF API FAILED
    if (provider.globalError != null) {
      return Center(
        child: Text(
          provider.globalError!,
          style: const TextStyle(color: Colors.red, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      );
    }

    // ⏳ NO WEATHER YET
    if (provider.currentWeather == null) {
      return const Center(
        child: Text(
          "Search or use GPS",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      );
    }

    final w = provider.currentWeather!;

    IconData getWeatherIcon(double temp) {
      if (temp <= 0) {
        return Icons.ac_unit; // ❄️ Freezing
      } else if (temp > 0 && temp < 10) {
        return Icons.cloudy_snowing; // 🥶 Cold and cloudy
      } else if (temp >= 10 && temp < 20) {
        return Icons.wb_cloudy; // 🌥️ Cool weather
      } else if (temp >= 20 && temp < 30) {
        return Icons.wb_sunny; // ☀️ Warm
      } else {
        return Icons.sunny; // 🔥 Hot
      }
    }

    Color getTempColor(double temp) {
      if (temp <= 0) return Colors.blue.shade200;
      if (temp < 10) return Colors.blue.shade400;
      if (temp < 20) return Colors.green.shade400;
      if (temp < 30) return Colors.orange.shade400;
      return Colors.red.shade400;
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 📍 LOCATION
            Text(
              "${w.region}\n${w.country}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),

            // 🌤️ ICON + TEMP
            Column(
              children: [
                Icon(
                  getWeatherIcon(w.temperature),
                  size: 79,
                  color: getTempColor(w.temperature),
                ),
                const SizedBox(width: 10),
                Text(
                  "${w.temperature}°C",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // 📌 DESCRIPTION
            Text(
              w.description,
              style: const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),

            // 🍃 WIND SPEED
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.air, color: Colors.white, size: 24),
                const SizedBox(width: 6),
                Text(
                  "${w.windSpeed} km/h",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
