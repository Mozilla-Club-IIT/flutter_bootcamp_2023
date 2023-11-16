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
}
