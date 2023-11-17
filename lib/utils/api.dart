import "dart:convert";

import "package:http/http.dart" as http;
import "package:mozc_flutter_bootcamp_23_showcase/models/city.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/weather.dart";

const apiUrl = "api.openweathermap.org";
const apiKey = String.fromEnvironment("MOZC_OPEN_WEATHER_API_KEY");

Future<List<City>> searchCities(String query) async {
  final url = Uri.https(apiUrl, "/geo/1.0/direct", {"q": query, "apiKey": apiKey});
  final res = await http.get(url);
  final List<dynamic> data = json.decode(res.body);

  return data.map((e) => City.fromMap(e as Map<String, dynamic>)).toList();
}

Future<CurrentWeatherData> getCurrentWeather(City city) async {
  final url = Uri.https(apiUrl, "/data/2.5/weather", {
    "lat": city.latitude.toString(),
    "lon": city.longitude.toString(),
    "appid": apiKey,
  });

  final res = await http.get(url);
  return CurrentWeatherData.fromJson(res.body);
}
