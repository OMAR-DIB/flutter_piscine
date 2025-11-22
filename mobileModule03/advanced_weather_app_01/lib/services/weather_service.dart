import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_models.dart';

class WeatherService {
  static Future<Map<String, dynamic>> fetchWeather(
    double latitude,
    double longitude,
    String name,
    String region,
    String country,
  ) async {

    final url = Uri.parse(
      "https://api.open-meteo.com/v1/forecast?"
      "latitude=$latitude&longitude=$longitude"
      "&current=temperature_2m,wind_speed_10m,weather_code"
      "&hourly=temperature_2m,weather_code,wind_speed_10m"
      "&daily=weather_code,temperature_2m_max,temperature_2m_min"
      "&timezone=auto"
    );

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    return {
      "current": _parseCurrent(data, name, region, country),
      "today": _parseToday(data),
      "weekly": _parseWeekly(data),
    };
  }

  // 🔎 Extract current weather
  static CurrentWeatherModel _parseCurrent(
      Map<String, dynamic> data,
      String name,
      String region,
      String country) {

    final current = data["current"];
    return CurrentWeatherModel(
      name: name,
      region: region,
      country: country,
      temperature: current["temperature_2m"],
      description: weatherCodeToText(current["weather_code"]),
      windSpeed: current["wind_speed_10m"],
    );
  }

  // ⏰ Today hourly data
  static List<TodayHourlyModel> _parseToday(Map<String, dynamic> data) {
    final times = data["hourly"]["time"];
    final temps = data["hourly"]["temperature_2m"];
    final codes = data["hourly"]["weather_code"];
    final winds = data["hourly"]["wind_speed_10m"];

    List<TodayHourlyModel> result = [];

    for (int i = 0; i < times.length; i++) {
      result.add(
        TodayHourlyModel(
          time: times[i].substring(11, 16), // hh:mm
          temperature: temps[i],
          description: weatherCodeToText(codes[i]),
          windSpeed: winds[i],
        ),
      );
    }
    return result;
  }

  // 📅 Weekly daily forecast
  static List<WeeklyDailyModel> _parseWeekly(Map<String, dynamic> data) {
    final dates = data["daily"]["time"];
    final minTemps = data["daily"]["temperature_2m_min"];
    final maxTemps = data["daily"]["temperature_2m_max"];
    final codes = data["daily"]["weather_code"];

    List<WeeklyDailyModel> result = [];
    for (int i = 0; i < dates.length; i++) {
      result.add(
        WeeklyDailyModel(
          date: dates[i],
          minTemperature: minTemps[i],
          maxTemperature: maxTemps[i],
          description: weatherCodeToText(codes[i]),
        ),
      );
    }
    return result;
  }

  // 🌦️ Convert weather code to text
  static String weatherCodeToText(int code) {
    if (code == 0) return "Clear sky";
    if ([1, 2, 3].contains(code)) return "Cloudy";
    if ([45, 48].contains(code)) return "Fog";
    if ([51, 53, 55].contains(code)) return "Drizzle";
    if ([61, 63, 65].contains(code)) return "Rain";
    if ([71, 73, 75].contains(code)) return "Snow";
    if ([80, 81, 82].contains(code)) return "Rain showers";
    if ([85, 86].contains(code)) return "Snow showers";
    if ([95, 96, 99].contains(code)) return "Thunderstorm";
    return "Unknown";
  }
}
