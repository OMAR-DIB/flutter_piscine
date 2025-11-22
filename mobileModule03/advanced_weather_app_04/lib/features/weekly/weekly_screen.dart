import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:advanced_weather_app_04/provider/nav/navigation_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String getWeekday(String date) {
  final dt = DateTime.parse(date); // "2025-11-23" etc.
  return ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][dt.weekday - 1];
}

IconData getWeatherIcon(String desc) {
  desc = desc.toLowerCase();
  if (desc.contains("rain")) return Icons.water_drop;
  if (desc.contains("cloud")) return Icons.cloud;
  if (desc.contains("storm")) return Icons.thunderstorm;
  if (desc.contains("snow")) return Icons.ac_unit;
  if (desc.contains("clear")) return Icons.wb_sunny;
  return Icons.device_thermostat;
}


class WeeklyScreen extends StatelessWidget {
  const WeeklyScreen({super.key});

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

    if (provider.currentWeather == null) {
      return const Center(child: Text("Search or use GPS"));
    }

    final weekly = provider.weeklyWeather;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // 📍 LOCATION
          Text(
            "${provider.cityName}, ${provider.region}\n${provider.country}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),

          // 📈 CHART
          SizedBox(
            height: 220,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  leftTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        int index = value.toInt();
                        if (index < 0 || index >= weekly.length) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          getWeekday(weekly[index].date),
                          style: const TextStyle(fontSize: 11),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),

                lineBarsData: [
                  // 🔵 MIN TEMP LINE
                  LineChartBarData(
                    isCurved: true,
                    barWidth: 3,
                    color: Colors.blueAccent,
                    dotData: FlDotData(show: false),
                    spots: [
                      for (int i = 0; i < weekly.length; i++)
                        FlSpot(i.toDouble(), weekly[i].minTemperature.toDouble()),
                    ],
                  ),

                  // 🔴 MAX TEMP LINE
                  LineChartBarData(
                    isCurved: true,
                    barWidth: 3,
                    color: Colors.redAccent,
                    dotData: FlDotData(show: false),
                    spots: [
                      for (int i = 0; i < weekly.length; i++)
                        FlSpot(i.toDouble(), weekly[i].maxTemperature.toDouble()),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // 📋 SCROLL LIST
          SizedBox(
  height: 140,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: weekly.length,
    itemBuilder: (context, index) {
      final d = weekly[index];
      return Container(
        width: 130,
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
            Text(
              getWeekday(d.date),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Icon(
              getWeatherIcon(d.description),
              size: 26,
              color: Colors.orangeAccent,
            ),
            const SizedBox(height: 4),
            Text(
              "${d.minTemperature}° / ${d.maxTemperature}°",
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              d.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
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
