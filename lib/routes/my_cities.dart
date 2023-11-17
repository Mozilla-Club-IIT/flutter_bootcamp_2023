import "package:flutter/material.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/city_list_item.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/error_screen.dart";
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
  City? get preferredCity => getPreferredCity();

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
      if (cities.isEmpty || preferredCity == null)
        const SliverFillRemaining(child: _EmptyCitiesScreen())
      else
        _CityListSliver(
          cities: cities,
          future: currentWeatherFuture,
          preferredCityIdentifier: preferredCity!.getIdentifier(),
          onPress: onListItemPressed,
        )
    ]);
  }

  Future<void> onAddPressed() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCity()));
    if (context.mounted) setState(() => {});
  }

  Future onListItemPressed(String? cityIdentifier) async {
    if (cityIdentifier == null) return;

    final city = cities.firstWhere((e) => e.getIdentifier() == cityIdentifier);
    await setPreferredCity(city);

    if (context.mounted) {
      setState(() => {});
    }
  }
}

class _EmptyCitiesScreen extends StatelessWidget {
  const _EmptyCitiesScreen();

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

class _CityListSliver extends StatelessWidget {
  final Iterable<City> cities;
  final String preferredCityIdentifier;
  final Future<Map<String, CurrentWeatherData>>? future;
  final void Function(String?) onPress;

  const _CityListSliver({
    required this.cities,
    required this.future,
    required this.preferredCityIdentifier,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return SliverFillRemaining(child: Center(child: ErrorScreen(error: snapshot.error!)));
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
              cityIdentifier: city.getIdentifier(),
              preferredCityIdentifier: preferredCityIdentifier,
              onPress: onPress,
            );
          },
        );
      },
    );
  }
}
