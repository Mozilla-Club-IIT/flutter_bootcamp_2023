import 'package:animations/animations.dart';
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
  // When adding a reverse transition between backward navigation,
  // we need to know which index was assigned to page before the setState re-render.
  PageIndex page = PageIndex.home;
  PageIndex pagePreRender = PageIndex.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: page.index,
        onDestinationSelected: (i) => setState(() => page = PageIndex.values[i]),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
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
      body: PageTransitionSwitcher(
        reverse: page.index < pagePreRender.index,
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, x, y) => SharedAxisTransition(
          animation: x,
          secondaryAnimation: y,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        ),
        child: buildPageView(page),
      ),
    );
  }

  Widget buildPageView(PageIndex page) {
    pagePreRender = page;

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
