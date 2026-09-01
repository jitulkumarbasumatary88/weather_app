import 'package:intl/intl.dart';

//////////////////// City Timezone Time (12-Hour) Format ////////////////////
String formatCityTime(num? timestampInSeconds, num? timezoneOffsetSeconds) {
  if (timestampInSeconds == null) return '--:--';
  final offset = timezoneOffsetSeconds?.toInt() ?? 0;

  final utcDateTime = DateTime.fromMillisecondsSinceEpoch(
    timestampInSeconds.toInt() * 1000,
    isUtc: true,
  );

  final cityLocalTime = utcDateTime.add(Duration(seconds: offset));

  return DateFormat('h:mm a').format(cityLocalTime);
}

//////////////////// City Timezone Date Format ////////////////////
String formatCityDate(num? timestampInSeconds, num? timezoneOffsetSeconds) {
  if (timestampInSeconds == null) return '';
  final offset = timezoneOffsetSeconds?.toInt() ?? 0;

  final utcDateTime = DateTime.fromMillisecondsSinceEpoch(
    timestampInSeconds.toInt() * 1000,
    isUtc: true,
  );
  final cityLocalTime = utcDateTime.add(Duration(seconds: offset));

  return DateFormat('EEEE, MMMM d').format(cityLocalTime);
}
