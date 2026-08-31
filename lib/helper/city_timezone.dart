import 'package:intl/intl.dart';

String formatCityTime(num? timestampInSeconds, num? timezoneOffsetSeconds) {
  if (timestampInSeconds == null) return '--:--';
  final offset = timezoneOffsetSeconds?.toInt() ?? 0;

  // 1. Epoch timestamp ko UTC DateTime me convert karo
  final utcDateTime = DateTime.fromMillisecondsSinceEpoch(
    timestampInSeconds.toInt() * 1000,
    isUtc: true,
  );

  final cityLocalTime = utcDateTime.add(Duration(seconds: offset));

  return DateFormat('h:mm a').format(cityLocalTime);
}
