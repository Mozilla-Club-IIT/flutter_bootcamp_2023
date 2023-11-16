import 'package:hive_flutter/adapters.dart';

part "city.g.dart";

@HiveType(typeId: 1)
class City {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String country;

  @HiveField(2)
  final double latitude;

  @HiveField(3)
  final double longitude;

  const City({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory City.fromJson(Map<String, dynamic> map) {
    return City(
      name: map["name"] as String,
      country: map["country"] as String,
      latitude: map["lat"] as double,
      longitude: map["lon"] as double,
    );
  }
}
