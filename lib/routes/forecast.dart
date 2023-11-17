import "package:flutter/material.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/error_screen.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/no_preferred_city_screen.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/weather_forecast_card.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/city.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/weather.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/api.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/hive.dart";

class Forecast extends StatefulWidget {
  const Forecast({super.key});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  City? get preferredCity => getPreferredCity();
  Future<List<ForecastWeatherDaySummary>>? weatherFuture;

  @override
  void initState() {
    super.initState();
    setForecastData();
  }

  void setForecastData() {
    final city = preferredCity;
    if (city == null) return;

    setState(() {
      weatherFuture = get5DayForecast(city).then((e) => ForecastWeatherDaySummary.fromList(e));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (preferredCity == null) {
      return NoPreferredCityScreen(onCityAdded: setForecastData);
    }

    final mediaPadding = MediaQuery.paddingOf(context);
    var padding = EdgeInsets.only(
      left: 8,
      right: 8,
      top: mediaPadding.top,
      bottom: mediaPadding.bottom + 8,
    );

    return FutureBuilder(
      future: weatherFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: ErrorScreen(error: snapshot.error!));
        }

        final data = snapshot.requireData;

        return MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: ListView.separated(
            itemCount: data.length,
            padding: padding,
            separatorBuilder: (context, index) => const SizedBox(height: 4),
            itemBuilder: (context, i) => WeatherForecastCard(data: data.elementAt(i)),
          ),
        );
      },
    );
  }
}
