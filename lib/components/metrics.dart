import 'package:flutter/material.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/models/weather.dart';

class MetricsBar extends StatelessWidget {
  final String wind;
  final String humidity;
  final String chanceOfRain;

  const MetricsBar({
    super.key,
    required this.wind,
    required this.humidity,
    required this.chanceOfRain,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Metric(type: MetricType.wind, value: wind),
      Metric(type: MetricType.humidity, value: humidity),
      Metric(type: MetricType.chanceOfRain, value: chanceOfRain),
    ]);
  }
}

class TinyMetricsBar extends StatelessWidget {
  final String wind;
  final String humidity;
  final String chanceOfRain;

  const TinyMetricsBar({
    super.key,
    required this.wind,
    required this.humidity,
    required this.chanceOfRain,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 28, children: [
      TinyMetric(type: MetricType.wind, value: wind),
      TinyMetric(type: MetricType.humidity, value: humidity),
      TinyMetric(type: MetricType.chanceOfRain, value: chanceOfRain),
    ]);
  }
}

class Metric extends StatelessWidget {
  final MetricType type;
  final String value;

  const Metric({super.key, required this.type, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;

    final iconTheme = theme.iconTheme.copyWith(size: 24, color: colors.onSurfaceVariant);

    return Column(mainAxisSize: MainAxisSize.min, children: [
      IconTheme(data: iconTheme, child: getIcon(type)),
      const SizedBox(height: 2),
      Text(value, style: text.labelLarge?.copyWith(color: colors.onSurface)),
    ]);
  }

  static Icon getIcon(MetricType type) {
    switch (type) {
      case MetricType.wind:
        return const Icon(Icons.air_rounded);
      case MetricType.humidity:
        return const Icon(Icons.water_drop_rounded);
      case MetricType.chanceOfRain:
        return const Icon(Icons.umbrella_rounded);
    }
  }
}

class TinyMetric extends StatelessWidget {
  final MetricType type;
  final String value;

  const TinyMetric({super.key, required this.type, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;

    final iconTheme = theme.iconTheme.copyWith(size: 16, color: colors.onSurfaceVariant);

    return Column(mainAxisSize: MainAxisSize.min, children: [
      IconTheme(data: iconTheme, child: Metric.getIcon(type)),
      const SizedBox(height: 2),
      Text(value, style: text.labelSmall?.copyWith(color: colors.onSurfaceVariant)),
    ]);
  }
}
