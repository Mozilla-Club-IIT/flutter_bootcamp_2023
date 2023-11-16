import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import "package:mozc_flutter_bootcamp_23_showcase/app.dart";
import 'package:mozc_flutter_bootcamp_23_showcase/models/city.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CityAdapter());
  await Hive.openBox("cities");

  runApp(const App());
}
