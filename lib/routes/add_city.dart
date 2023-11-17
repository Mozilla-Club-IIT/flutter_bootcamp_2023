import "package:flutter/material.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/city.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/api.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/hive.dart";

class AddCity extends StatefulWidget {
  const AddCity({super.key});

  @override
  State<AddCity> createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
  final searchController = TextEditingController();

  Future<List<City>>? citiesFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add a city"), bottom: buildSearchBar()),
      body: FutureBuilder(
        future: citiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(child: Text("Search a city"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              final city = data.elementAt(i);

              return ListTile(
                title: Text(city.name),
                subtitle: Text(city.country),
                onTap: () => onItemPress(city),
              );
            },
          );
        },
      ),
    );
  }

  PreferredSize buildSearchBar() {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 64),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          onSubmitted: onSubmit,
          controller: searchController,
          decoration: const InputDecoration(
            isDense: true,
            label: Text("Search"),
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search_rounded, size: 24),
          ),
        ),
      ),
    );
  }

  void onSubmit(String value) {
    setState(() {
      citiesFuture = searchCities(value);
    });
  }

  void onItemPress(City city) async {
    await addCity(city);

    final preferredCity = getPreferredCity();
    if (preferredCity == null) {
      await setPreferredCity(city);
    }

    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
