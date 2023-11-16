import 'package:flutter/material.dart';

class AddCity extends StatefulWidget {
  const AddCity({super.key});

  @override
  State<AddCity> createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add a city"), bottom: buildSearchBar()),
      body: ListView.builder(
        itemBuilder: (context, i) {
          return ListTile(
            title: Text("City $i"),
            subtitle: const Text("Country"),
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
          onSubmitted: (value) => {},
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
}
