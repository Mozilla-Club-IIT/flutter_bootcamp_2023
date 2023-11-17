import "dart:convert";

import "package:mozc_flutter_bootcamp_23_showcase/utils/parse.dart";

class CurrentWeatherData {
  final double temperature;
  final int humidity;
  final int pressure;
  final double windSpeed;

  final WeatherConditionData weather;

  const CurrentWeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.weather,
  });

  factory CurrentWeatherData.fromMap(Map<String, dynamic> map) {
    final main = map["main"] as Map<String, dynamic>;
    final wind = map["wind"] as Map<String, dynamic>;

    final weather = (map["weather"] as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .firstWhere((condition) => WeatherStatus.isValid(condition["main"] as String));

    return CurrentWeatherData(
      temperature: parseToDouble(main["temp"]),
      humidity: main["humidity"] as int,
      pressure: main["pressure"] as int,
      windSpeed: parseToDouble(wind["speed"]),
      weather: WeatherConditionData.fromMap(weather),
    );
  }

  factory CurrentWeatherData.fromJson(String source) =>
      CurrentWeatherData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ForecastWeatherData extends CurrentWeatherData {
  final double chanceOfRain;
  final DateTime date;

  const ForecastWeatherData({
    required super.temperature,
    required super.humidity,
    required super.windSpeed,
    required super.pressure,
    required super.weather,
    required this.chanceOfRain,
    required this.date,
  });

  factory ForecastWeatherData.fromMap(Map<String, dynamic> map) {
    final su = CurrentWeatherData.fromMap(map);

    return ForecastWeatherData(
      chanceOfRain: parseToDouble(map["pop"]),
      date: DateTime.parse(map["dt_txt"]),
      humidity: su.humidity,
      pressure: su.pressure,
      temperature: su.temperature,
      weather: su.weather,
      windSpeed: su.windSpeed,
    );
  }
}

class ForecastWeatherDaySummary {
  final (DateTime, DateTime) timeRange;
  final (double, double) temperatureRange;
  final (double, double) chanceOfRainRange;
  final (int, int) humidityRange;
  final (double, double) windSpeedRange;

  final WeatherConditionData weather;

  const ForecastWeatherDaySummary({
    required this.timeRange,
    required this.temperatureRange,
    required this.chanceOfRainRange,
    required this.humidityRange,
    required this.windSpeedRange,
    required this.weather,
  });

  factory ForecastWeatherDaySummary.fromDay(List<ForecastWeatherData> list) {
    DateTime? timeStart;
    DateTime? timeEnd;
    double? tempLow;
    double? tempHigh;
    double? rainLow;
    double? rainHigh;
    int? humidityLow;
    int? humidityHigh;
    double? windSpeedLow;
    double? windSpeedHigh;
    WeatherConditionData? weather;

    for (final item in list) {
      if (timeEnd == null || item.date.isAfter(timeEnd)) timeEnd = item.date;
      if (timeStart == null || item.date.isBefore(timeStart)) timeStart = item.date;

      if (tempLow == null || tempLow > item.temperature) tempLow = item.temperature;
      if (tempHigh == null || tempHigh < item.temperature) tempHigh = item.temperature;

      if (rainLow == null || rainLow > item.chanceOfRain) rainLow = item.chanceOfRain;
      if (rainHigh == null || rainHigh < item.chanceOfRain) {
        rainHigh = item.chanceOfRain;
        weather = item.weather;
      }

      if (humidityLow == null || humidityLow > item.humidity) humidityLow = item.humidity;
      if (humidityHigh == null || humidityHigh < item.humidity) humidityHigh = item.humidity;

      if (windSpeedLow == null || windSpeedLow > item.windSpeed) windSpeedLow = item.windSpeed;
      if (windSpeedHigh == null || windSpeedHigh < item.windSpeed) windSpeedHigh = item.windSpeed;
    }

    if (timeStart == null ||
        timeEnd == null ||
        tempLow == null ||
        tempHigh == null ||
        rainLow == null ||
        rainHigh == null ||
        humidityLow == null ||
        humidityHigh == null ||
        windSpeedLow == null ||
        windSpeedHigh == null ||
        weather == null) {
      throw StateError("Invalid data. All fields must be non-null.");
    }

    return ForecastWeatherDaySummary(
      timeRange: (timeStart, timeEnd),
      temperatureRange: (tempLow, tempHigh),
      chanceOfRainRange: (rainLow, rainHigh),
      humidityRange: (humidityLow, humidityHigh),
      windSpeedRange: (windSpeedLow, windSpeedLow),
      weather: weather,
    );
  }

  static List<ForecastWeatherDaySummary> fromList(List<ForecastWeatherData> list) {
    final e = list.fold(<String, List<ForecastWeatherData>>{}, (map, e) {
      final key = "${e.date.year}-${e.date.month}-${e.date.day}";

      map.update(key, (list) {
        list.add(e);
        return list;
      }, ifAbsent: () => [e]);

      return map;
    });

    return e.values.map((e) => ForecastWeatherDaySummary.fromDay(e)).toList();
  }
}

class WeatherConditionData {
  final int id;
  final String iconId;
  final WeatherStatus status;

  const WeatherConditionData({
    required this.id,
    required this.iconId,
    required this.status,
  });

  factory WeatherConditionData.fromMap(Map<String, dynamic> map) {
    return WeatherConditionData(
      id: map["id"] as int,
      iconId: map["icon"] as String,
      status: WeatherStatus.fromMap(map["main"] as String),
    );
  }
}

enum WeatherStatus {
  thunderstorm,
  drizzle,
  rain,
  snow,
  clear,
  clouds;

  static bool isValid(String status) {
    try {
      WeatherStatus.fromMap(status);
      return true;
    } on StateError {
      return false;
    }
  }

  factory WeatherStatus.fromMap(String status) {
    switch (status.toLowerCase()) {
      case "thunderstorm":
        return WeatherStatus.thunderstorm;
      case "drizzle":
        return WeatherStatus.drizzle;
      case "rain":
        return WeatherStatus.rain;
      case "snow":
        return WeatherStatus.snow;
      case "clear":
        return WeatherStatus.clear;
      case "clouds":
        return WeatherStatus.clouds;
      default:
        throw StateError("Invalid weather status: $status");
    }
  }

  String asHumanReadable() {
    switch (this) {
      case WeatherStatus.thunderstorm:
        return "Thunderstorm";
      case WeatherStatus.drizzle:
        return "Drizzle";
      case WeatherStatus.rain:
        return "Rain";
      case WeatherStatus.snow:
        return "Snow";
      case WeatherStatus.clear:
        return "Clear";
      case WeatherStatus.clouds:
        return "Clouds";
    }
  }
}

enum MetricType {
  wind,
  humidity,
  pressure,
  chanceOfRain,
}
