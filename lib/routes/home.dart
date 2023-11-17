import "package:flutter/material.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/error_screen.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/metrics.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/weather_bar.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/city.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/weather.dart";
import "package:mozc_flutter_bootcamp_23_showcase/routes/add_city.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/api.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/hive.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  City? get preferredCity => getPreferredCity();

  Future<CurrentWeatherData>? weatherFuture;

  @override
  void initState() {
    super.initState();
    setWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final city = preferredCity;
    if (city == null) {
      return _EmptyHome(onSelected: setWeatherData);
    }

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

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 56),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherBar(
                  date: DateTime.now(),
                  temperature: data.temperature,
                  location: "${city.name},\n${city.country}",
                  status: WeatherStatus.rain,
                ),
                Center(
                  child: Image(
                    height: 256,
                    width: 256,
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.high,
                    image: AssetImage("assets/icons/${data.weather.iconId}.png"),
                  ),
                ),
                MetricsBar(humidity: data.humidity, wind: data.windSpeed, pressure: data.pressure)
              ],
            ),
          ),
        );
      },
    );
  }

  void setWeatherData() {
    final city = preferredCity;
    if (city == null) return;

    setState(() {
      weatherFuture = getCurrentWeather(city);
    });
  }
}

class _EmptyHome extends StatelessWidget {
  final VoidCallback onSelected;

  const _EmptyHome({required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final colors = theme.colorScheme;

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.priority_high_rounded, size: 64, color: colors.primary),
        const SizedBox(height: 32),
        Text("Nothing to show yet!", style: text.bodyLarge),
        Text("Start by adding a city", style: text.bodyLarge),
        const SizedBox(height: 32),
        FilledButton.tonalIcon(
          onPressed: () => {},
          icon: const Icon(Icons.add_rounded),
          label: const Text("Add a city"),
        )
      ]),
    );
  }

  Future<void> onAddCity(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCity()));

    if (context.mounted) {
      onSelected.call();
    }
  }
}
