import "package:intl/intl.dart";

String getFancyDate(DateTime date) {
  return DateFormat("EEE, MMM d", "en-US").format(date);
}

bool isDateEqualInYMD(DateTime o1, DateTime o2) {
  return o1.year == o2.year && o1.month == o2.month && o1.day == o2.day;
}

String getRelativeDateString(DateTime date) {
  final now = DateTime.now();
  final dayAfter = now.add(const Duration(days: 1));
  final dayBefore = now.subtract(const Duration(days: 1));

  if (isDateEqualInYMD(date, dayBefore)) return "Yesterday";
  if (isDateEqualInYMD(date, now)) return "Today";
  if (isDateEqualInYMD(date, dayAfter)) return "Tomorrow";

  return DateFormat("EEEE", "en-US").format(date);
}
