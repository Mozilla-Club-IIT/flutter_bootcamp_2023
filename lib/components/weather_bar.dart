import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/components/weather_status.dart';

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

    final df = DateFormat("EEE, MMM d", "en-US");

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            place,
            style: text.headlineLarge?.copyWith(color: color.primary, fontWeight: FontWeight.bold),
          ),
          WeatherStatus(degree: degree, status: status),
        ]),
        Text(
          df.format(date),
          style: text.labelLarge?.copyWith(color: color.primary.withOpacity(0.5)),
        ),
      ],
    );
  }
}
