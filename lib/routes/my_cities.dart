import 'package:flutter/material.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/components/city_list_item.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/models/weather.dart';

class MyCities extends StatefulWidget {
  const MyCities({super.key});

  @override
  State<MyCities> createState() => _MyCitiesState();
}

class _MyCitiesState extends State<MyCities> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        title: const Text("My Cities"),
        floating: true,
        actions: [IconButton(onPressed: () => {}, icon: const Icon(Icons.add_rounded))],
      ),
      SliverList.builder(
        itemBuilder: (context, i) {
          return const CityListItem(
            location: "Colombo",
            temperature: 19,
            status: WeatherStatus.clear,
            iconId: "01d",
          );
        },
      )
    ]);
  }
}
