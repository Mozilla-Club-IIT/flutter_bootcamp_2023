double parseToDouble(dynamic value) {
  return value is int ? value.toDouble() : value as double;
}
