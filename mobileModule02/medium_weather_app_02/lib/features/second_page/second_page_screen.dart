import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medium_weather_app_02/provider/nav/navigation_provider.dart';
class SecondPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NavigationProvider>();

    if (provider.todayWeather.isEmpty) {
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
