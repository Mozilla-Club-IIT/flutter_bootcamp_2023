import "package:hive/hive.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/city.dart";

Future<void> addCity(City city) async {
  final box = Hive.box<City>("cities");
  await box.put("${city.name}-${city.country}", city);
}

Iterable<City> getCities() {
  final box = Hive.box<City>("cities");
  return box.values;
}

Future<void> setPreferredCity(City city) async {
  final box = Hive.box("preferences");
  await box.put("city", city);
}

City? getPreferredCity() {
  final box = Hive.box("preferences");
  return box.get("city") as City?;
}
