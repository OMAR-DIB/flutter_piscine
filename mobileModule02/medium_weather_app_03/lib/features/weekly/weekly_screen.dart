import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medium_weather_app_03/provider/nav/navigation_provider.dart';
class WeeklyScreen extends StatelessWidget {
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
    return Column(
      children: [
        Text("${provider.cityName}\n${provider.region}\n${provider.country}", textAlign: TextAlign.center),
        Expanded(
          child: ListView.builder(
            itemCount: provider.weeklyWeather.length,
            itemBuilder: (context, index) {
              final d = provider.weeklyWeather[index];
              return ListTile(
                title: Text("${d.date}"),
                subtitle: Text("${d.minTemperature}°C - ${d.maxTemperature}°C — ${d.description}"),
              );
            },
          ),
        )
      ],
    );
  }
}
