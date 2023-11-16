import 'package:flutter/material.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/utils/date.dart';

class WeatherBar extends StatelessWidget {
  final int degree;
  final String status;
  final String place;
  final DateTime date;

  const WeatherBar({
    super.key,
    required this.degree,
    required this.status,
    required this.place,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final color = theme.colorScheme;

    final dateString = getFancyDate(date);

    final placeTextStyle = text.headlineLarge?.copyWith(
      color: color.primary,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(place, style: placeTextStyle),
          WeatherTempStatus(degree: degree, status: status),
        ]),
        Text(dateString, style: text.labelLarge?.copyWith(color: color.primary.withOpacity(0.5))),
      ],
    );
  }
}

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
