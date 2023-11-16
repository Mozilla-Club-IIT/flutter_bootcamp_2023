import 'package:flutter/material.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/components/city_list_item.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/models/city.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/models/weather.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/routes/add_city.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/utils/hive.dart';

class MyCities extends StatefulWidget {
  const MyCities({super.key});

  @override
  State<MyCities> createState() => _MyCitiesState();
}

class _MyCitiesState extends State<MyCities> {
  Iterable<City> get cities => getCities();

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
        SliverList.builder(
          itemCount: cities.length,
          itemBuilder: (context, i) {
            final city = cities.elementAt(i);

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
