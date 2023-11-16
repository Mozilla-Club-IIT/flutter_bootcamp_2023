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
