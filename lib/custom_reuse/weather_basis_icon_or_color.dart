import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherBasisIconOrColor {
  static IconData getIcon(String? condition, {String? iconCode}) {
    final isNight = iconCode?.contains('n') ?? false;

    switch (condition?.toLowerCase()) {
      case 'clear':
        return isNight ? Icons.nights_stay_rounded : Icons.wb_sunny_rounded;

      case 'clouds':
        return Icons.wb_cloudy_rounded;

      case 'rain':
        return CupertinoIcons.cloud_rain_fill;

      case 'drizzle':
        return Icons.opacity_rounded;

      case 'thunderstorm':
        return Icons.thunderstorm_rounded;

      case 'snow':
        return Icons.ac_unit_rounded;

      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
        return Icons.cloud_queue_rounded;

      case 'squall':
      case 'tornado':
        return Icons.air_rounded;

      default:
        return Icons.wb_sunny_rounded;
    }
  }

  static Color getColor(String? condition, {String? iconCode}) {
    final isNight = iconCode?.contains('n') ?? false;

    switch (condition?.toLowerCase()) {
      case 'clear':
        return isNight ? Colors.indigoAccent : Colors.amber;

      case 'clouds':
        return Colors.blueGrey.shade100;

      case 'rain':
        return Colors.lightBlueAccent;

      case 'drizzle':
        return Colors.cyanAccent;

      case 'thunderstorm':
        return Colors.orangeAccent;

      case 'snow':
        return Colors.white;

      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
        return Colors.grey.shade400;

      case 'squall':
      case 'tornado':
        return Colors.tealAccent;

      default:
        return Colors.white70;
    }
  }
}
