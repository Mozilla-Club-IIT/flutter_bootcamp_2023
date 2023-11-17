/// Converts a given value in m/s to km/h
double convertMpsToKmph(double value) {
  // 3600 seconds in an hour and 1000 meters in a kilometer (3600/1000 = 3.6)
  return value * 3.6;
}

/// Convert a given value in kelvin to celsius
double convertKelvinToCelsius(double value) {
  return value - 273.15;
}
