import 'package:flutter/material.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/components/weather_card.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/models/weather.dart';

class Forecast extends StatefulWidget {
  const Forecast({super.key});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final now = DateTime.now();

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: ListView.separated(
        itemCount: 5,
        padding: EdgeInsets.only(left: 8, right: 8, top: padding.top, bottom: padding.bottom + 8),
        separatorBuilder: (context, index) => const SizedBox(height: 4),
        itemBuilder: (context, i) {
          return WeatherCard(
            temperature: 19,
            status: WeatherStatus.clear,
            date: now.copyWith(day: now.day + i),
            wind: "120km/h",
            humidity: "22%",
            chanceOfRain: "11%",
          );
        },
      ),
    );
  }
}
