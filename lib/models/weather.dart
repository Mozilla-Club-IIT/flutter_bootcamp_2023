enum WeatherStatus {
  thunderstorm,
  drizzle,
  rain,
  snow,
  clear,
  clouds;

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
