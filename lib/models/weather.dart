import "dart:convert";

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeatherData {
  final double temperature;
  final int humidity;
  final double windSpeed;

  final WeatherConditionData weather;

  const WeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.weather,
  });

  factory WeatherData.fromMap(Map<String, dynamic> map) {
    final main = map["main"] as Map<String, dynamic>;
    final wind = map["wind"] as Map<String, dynamic>;

    final weather = (map["weather"] as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .firstWhere((condition) => WeatherStatus.isValid(condition["main"] as String));

    return WeatherData(
      temperature: main["temp"] as double,
      humidity: main["humidity"] as int,
      windSpeed: wind["speed"] as double,
      weather: WeatherConditionData.fromMap(weather),
    );
  }

  factory WeatherData.fromJson(String source) =>
      WeatherData.fromMap(json.decode(source) as Map<String, dynamic>);
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
      iconId: map["iconId"] as String,
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
    switch (status) {
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
  chanceOfRain,
}
