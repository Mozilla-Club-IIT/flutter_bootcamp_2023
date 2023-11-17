import "package:flutter/material.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/city_list_item.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/city.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/weather.dart";
import "package:mozc_flutter_bootcamp_23_showcase/routes/add_city.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/api.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/hive.dart";

class MyCities extends StatefulWidget {
  const MyCities({super.key});

  @override
  State<MyCities> createState() => _MyCitiesState();
}

class _MyCitiesState extends State<MyCities> {
  Iterable<City> get cities => getCities();
  Future<Map<String, CurrentWeatherData>>? currentWeatherFuture;

  @override
  void initState() {
    super.initState();
    currentWeatherFuture = getData();
  }

  Future<Map<String, CurrentWeatherData>> getData() async {
    final Map<String, CurrentWeatherData> map = {};

    for (final city in cities) {
      final currentWeather = await getCurrentWeather(city);
      map[city.getIdentifier()] = currentWeather;
      await Future.delayed(const Duration(milliseconds: 500));
    }

    return map;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        title: const Text("My Cities"),
        floating: true,
        actions: [IconButton(onPressed: onAddPressed, icon: const Icon(Icons.add_rounded))],
      ),
      if (cities.isEmpty)
        const SliverFillRemaining(child: _EmptyScreen())
      else
        _ItemListSliver(cities: cities, future: currentWeatherFuture)
    ]);
  }

  Future<void> onAddPressed() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCity()));
    if (context.mounted) setState(() => {});
  }
}

class _EmptyScreen extends StatelessWidget {
  const _EmptyScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.location_off_rounded, size: 56, color: colors.primary),
      const SizedBox(height: 12),
      Text("No cities are selected yet", style: text.labelLarge),
      Text("Use the + button to add a city!", style: text.labelLarge)
    ]);
  }
}

class _ItemListSliver extends StatelessWidget {
  final Iterable<City> cities;
  final Future<Map<String, CurrentWeatherData>>? future;

  const _ItemListSliver({required this.cities, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
        }

        final data = snapshot.requireData;

        return SliverList.builder(
          itemCount: cities.length,
          itemBuilder: (context, i) {
            final city = cities.elementAt(i);
            final current = data[city.getIdentifier()]!;

            return CityListItem(
              location: "${city.name}, ${city.country}",
              temperature: current.temperature,
              status: current.weather.status,
              iconId: current.weather.iconId,
            );
          },
        );
      },
    );
  }
}
