class CurrentWeatherModel {
  final String name;
  final String region;
  final String country;
  final double temperature;
  final String description;
  final double windSpeed;

  CurrentWeatherModel({
    required this.name,
    required this.region,
    required this.country,
    required this.temperature,
    required this.description,
    required this.windSpeed,
  });
}

class TodayHourlyModel {
  final String time;
  final double temperature;
  final String description;
  final double windSpeed;

  TodayHourlyModel({
    required this.time,
    required this.temperature,
    required this.description,
    required this.windSpeed,
  });
}

class WeeklyDailyModel {
  final String date;
  final double minTemperature;
  final double maxTemperature;
  final String description;

  WeeklyDailyModel({
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
    required this.description,
  });
}
