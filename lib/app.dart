import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/routes/layout.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    // Set the UI mode to ede for components to go under system ui.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    setSystemOverlays();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0x001e1e1e)),
      home: const RootLayout(),
    );
  }

  void setSystemOverlays() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }
}
