import 'package:flutter/material.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/components/weather_status.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final color = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Colombo,\nSri Lanka",
              style: text.headlineLarge?.copyWith(
                color: color.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const WeatherStatus(degree: 19, status: "Rainy"),
          ]),
          Text(
            "Tue, Jun 30",
            style: text.labelLarge?.copyWith(color: color.primary.withOpacity(0.5)),
          ),
        ]),
      ),
    );
  }
}
