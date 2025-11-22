import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:advanced_weather_app_04/provider/nav/navigation_provider.dart';

IconData getWeatherIcon(String desc) {
  desc = desc.toLowerCase();
  if (desc.contains("rain")) return Icons.water_drop;
  if (desc.contains("cloud")) return Icons.cloud;
  if (desc.contains("storm")) return Icons.thunderstorm;
  if (desc.contains("snow")) return Icons.ac_unit;
  if (desc.contains("clear")) return Icons.wb_sunny;
  return Icons.device_thermostat;
}

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NavigationProvider>();
String extractHour(String time) {
  return time.split(":")[0]; // "00:00" → "00"
}
    if (provider.globalError != null) {
      return Center(
        child: Text(
          provider.globalError!,
          style: const TextStyle(color: Colors.red, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (provider.currentWeather == null) {
      return const Center(
        child: Text("Search or use GPS"),
      );
    }

    final today = provider.todayWeather;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 📌 LOCATION
          Text(
            "${provider.cityName}, ${provider.region}\n${provider.country}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),

          // 📈 TEMPERATURE CHART
          SizedBox(
  height: 200,
  child: LineChart(
    LineChartData(
      minX: 0,
      maxX: today.length.toDouble() - 1,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(),
        rightTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
        bottomTitles: AxisTitles(
  sideTitles: SideTitles(
    showTitles: true,
    reservedSize: 28,
    getTitlesWidget: (value, _) {
      int index = value.toInt();

      // ❌ ignore if out of range or >= 24 hours
      if (index < 0 || index >= today.length) {
        return const SizedBox.shrink();
      }

      // 🕐 take only the hour and remove leading 0
      String hour = int.parse(today[index].time.split(":")[0]).toString();

      return Text(hour, style: const TextStyle(fontSize: 11));
    },
  ),
),

      ),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          barWidth: 3,
          gradient: const LinearGradient(
            colors: [Colors.orange, Colors.deepOrange],
          ),
          dotData: FlDotData(show: false),
          spots: [
            for (int i = 0; i < today.length; i++)
              FlSpot(i.toDouble(), today[i].temperature.toDouble())
          ],
        ),
      ],
    ),
  ),
),
          const SizedBox(height: 10),

          // 📋 SCROLLABLE LIST
          SizedBox(
  height: 130,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: today.length,
    itemBuilder: (context, index) {
      final h = today[index];
      return Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(getWeatherIcon(h.description), color: Colors.orange, size: 24),
            const SizedBox(height: 6),
            Text(h.time, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text("${h.temperature}°C", style: const TextStyle(fontSize: 16)),
            Text("${h.windSpeed} km/h", style: const TextStyle(fontSize: 11)),
          ],
        ),
      );
    },
  ),
)

        ],
      ),
    );
  }
}

