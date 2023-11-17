import "package:flutter/material.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/metrics.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/weather.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/date.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/units.dart";

class WeatherForecastCard extends StatelessWidget {
  final ForecastWeatherDaySummary data;

  const WeatherForecastCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      elevation: 0,
      shadowColor: Colors.transparent,
      color: colors.surfaceVariant,
      child: Container(
        height: 156,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: _WeatherCardInfo(
                date: data.timeRange.$1,
                chanceOfRainRange: data.chanceOfRainRange,
                humidityRange: data.humidityRange,
                windSpeedRange: data.windSpeedRange,
                weather: data.weather,
              ),
            ),
            _TemperatureStatus(
              temperatureRange: data.temperatureRange,
              status: data.weather.status,
              iconId: data.weather.iconId,
            )
          ],
        ),
      ),
    );
  }
}

class _WeatherCardInfo extends StatelessWidget {
  final DateTime date;

  final (double, double) chanceOfRainRange;
  final (int, int) humidityRange;
  final (double, double) windSpeedRange;
  final WeatherConditionData weather;

  const _WeatherCardInfo({
    required this.date,
    required this.chanceOfRainRange,
    required this.humidityRange,
    required this.windSpeedRange,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final colors = theme.colorScheme;

    final dateString = getFancyDate(date);
    final relativeDateString = getRelativeDateString(date);

    final relativeDateTextStyle = text.titleLarge?.copyWith(
      color: colors.primary,
      fontWeight: FontWeight.w500,
    );

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(relativeDateString, style: relativeDateTextStyle),
      Text(dateString, style: text.labelMedium?.copyWith(color: colors.onSurfaceVariant)),
      const Spacer(),
      TinyMetricsBar(
        humidity: humidityRange.$2,
        wind: windSpeedRange.$2,
        chanceOfRain: chanceOfRainRange.$2,
      ),
    ]);
  }
}

class _TemperatureStatus extends StatelessWidget {
  final (double, double) temperatureRange;
  final WeatherStatus status;
  final String iconId;

  const _TemperatureStatus({
    required this.temperatureRange,
    required this.status,
    required this.iconId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final colors = theme.colorScheme;

    final temperatureLow = convertKelvinToCelsius(temperatureRange.$1);
    final temperatureHigh = convertKelvinToCelsius(temperatureRange.$2);
    final tempStyle = text.titleMedium?.copyWith(
      color: colors.primary,
      fontWeight: FontWeight.w900,
    );

    return SizedBox(
      width: 128,
      child: Stack(children: [
        Center(
          child: Image(
            height: 128,
            width: 128,
            fit: BoxFit.fitWidth,
            filterQuality: FilterQuality.high,
            image: AssetImage("assets/icons/$iconId.png"),
          ),
        ),
        Positioned(
          top: 0,
          right: 6,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(temperatureLow.toStringAsFixed(1), style: tempStyle),
              const SizedBox(width: 1),
              Text("/", style: tempStyle?.copyWith(color: colors.onSurfaceVariant)),
              const SizedBox(width: 1),
              Text(temperatureHigh.toStringAsFixed(1), style: tempStyle),
              Text("°C", style: text.labelMedium?.copyWith(color: colors.primary)),
            ],
          ),
        )
      ]),
    );
  }
}
