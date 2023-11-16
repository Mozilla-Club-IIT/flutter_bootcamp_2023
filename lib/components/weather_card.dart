import 'package:flutter/material.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/models/weather.dart';

class WeatherCard extends StatelessWidget {
  final DateTime date;
  final int degree;
  final WeatherStatus status;

  const WeatherCard({
    super.key,
    required this.date,
    required this.degree,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
