import 'package:flutter/material.dart';

class WeatherTempStatus extends StatelessWidget {
  final int degree;
  final String status;

  const WeatherTempStatus({super.key, required this.degree, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final colors = theme.colorScheme;

    final tempTextStyle = text.displayLarge?.copyWith(
      color: colors.primary,
      fontWeight: FontWeight.w900,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(mainAxisSize: MainAxisSize.min, children: [
          Text(degree.toString(), style: tempTextStyle),
          Text(status, style: text.titleMedium?.copyWith(color: colors.primary)),
        ]),
        Text("°C", style: text.labelLarge?.copyWith(color: colors.primary)),
      ],
    );
  }
}
