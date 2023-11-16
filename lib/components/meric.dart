import 'package:flutter/material.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/models/weather.dart';

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
      IconTheme(data: iconTheme, child: getIcon()),
      const SizedBox(height: 2),
      Text(value, style: text.labelLarge?.copyWith(color: colors.onSurface)),
    ]);
  }

  Icon getIcon() {
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
