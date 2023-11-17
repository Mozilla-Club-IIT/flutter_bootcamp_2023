import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mozc_flutter_bootcamp_23_showcase/models/city.dart';

const apiKey = "cc5e52326e06b6ee1530ce5b18371a83";
const apiUrl = "api.openweathermap.org";

Future<List<City>> searchCities(String query) async {
  final url = Uri.https(apiUrl, "/geo/1.0/direct", {"q": query, "apiKey": apiKey});
  final res = await http.get(url);
  final List<dynamic> data = jsonDecode(res.body);

  return data.map((e) => City.fromMap(e as Map<String, dynamic>)).toList();
}
