import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:advanced_weather_app/provider/nav/navigation_provider.dart';
class SecondPageScreen extends StatelessWidget {
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
            itemCount: provider.todayWeather.length,
            itemBuilder: (context, index) {
              final h = provider.todayWeather[index];
              return ListTile(
                title: Text("${h.time}  ${h.temperature}°C"),
                subtitle: Text("${h.description} | ${h.windSpeed} km/h"),
              );
            },
          ),
        )
      ],
    );
  }
}
