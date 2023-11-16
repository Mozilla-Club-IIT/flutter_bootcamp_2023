import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/components/city_list_item.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/models/city.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/models/weather.dart';

class MyCities extends StatefulWidget {
  const MyCities({super.key});

  @override
  State<MyCities> createState() => _MyCitiesState();
}

class _MyCitiesState extends State<MyCities> {
  Iterable<City> get places {
    final box = Hive.box<City>("cities");
    return box.values;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        title: const Text("My Cities"),
        floating: true,
        actions: [IconButton(onPressed: () => {}, icon: const Icon(Icons.add_rounded))],
      ),
      if (places.isEmpty)
        const SliverFillRemaining(child: _EmptyScreen())
      else
        SliverList.builder(
          itemCount: places.length,
          itemBuilder: (context, i) {
            final city = places.elementAt(i);

            return CityListItem(
              location: "${city.name}, ${city.country}",
              temperature: 19,
              status: WeatherStatus.clear,
              iconId: "01d",
            );
          },
        )
    ]);
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
