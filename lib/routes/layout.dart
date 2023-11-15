import 'package:flutter/material.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/routes/forecast.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/routes/home.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/routes/my_cities.dart';

class RootLayout extends StatefulWidget {
  const RootLayout({super.key});

  @override
  State<RootLayout> createState() => _RootLayoutState();
}

class _RootLayoutState extends State<RootLayout> {
  PageIndex page = PageIndex.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: page.index,
        onDestinationSelected: (i) => setState(() => page = PageIndex.values[i]),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_filled),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map_rounded),
            label: "My Cities",
          ),
          NavigationDestination(
            icon: Icon(Icons.thunderstorm_outlined),
            selectedIcon: Icon(Icons.thunderstorm_rounded),
            label: "Forecast",
          ),
        ],
      ),
      body: buildPage(),
    );
  }

  Widget buildPage() {
    switch (page) {
      case PageIndex.home:
        return const Home();
      case PageIndex.myCities:
        return const MyCities();
      case PageIndex.forecast:
        return const Forecast();
    }
  }
}

enum PageIndex { home, myCities, forecast }
