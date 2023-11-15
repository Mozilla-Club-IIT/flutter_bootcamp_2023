import 'package:flutter/material.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/components/meric.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/components/weather_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 56),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WeatherBar(
              date: DateTime(2023, 11, 14),
              degree: 19,
              place: "Colombo,\nSri Lanka",
              status: "Rainy",
            ),
            const Center(child: Icon(Icons.sunny, size: 128)),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Metric(icon: Icon(Icons.air_rounded), value: "106km/h"),
              Metric(icon: Icon(Icons.water_drop_rounded), value: "22%"),
              Metric(icon: Icon(Icons.umbrella_rounded), value: "11%"),
            ]),
          ],
        ),
      ),
    );
  }
}
