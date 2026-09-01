import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherBasisIconOrColor {
  static IconData getIcon(String? condition, {String? iconCode}) {
    final isNight = iconCode?.contains('n') ?? false;

    //////////////////// Icons ////////////////////
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

  //////////////////// Icon Colors ////////////////////
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

  //////////////////// Dynamic Background Gradients ////////////////////
  static List<Color> getBackgroundGradient(
    String? condition, {
    String? iconCode,
  }) {
    // Default Gradient When Weather Null/Loading
    if (condition == null) {
      return const [Color(0xFF0F172A), Color(0xFF1E293B)];
    }
    final isNight = iconCode?.contains('n') ?? false;
    // Night Midnight Dky Gradients
    if (isNight) {
      return const [Color(0xFF0B0E14), Color(0xFF1B1B2F)];
    }
    switch (condition.toLowerCase()) {
      case 'clear':
        return const [Color(0xFF1E3C72), Color(0xFF2A5298)];

      case 'clouds':
        return const [Color(0xFF2C3E50), Color(0xFF3F51B5)];

      case 'rain':
        return const [Color(0xFF102A43), Color(0xFF1F3A52)];

      case 'drizzle':
        return const [Color(0xFF1A365D), Color(0xFF2B4C7E)];

      case 'thunderstorm':
        return const [
          Color(0xFF160F28),
          Color(0xFF2B193D),
        ]; // Dark Electric Purple

      case 'snow':
        return const [Color(0xFF1C2A38), Color(0xFF3A506B)];

      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
        return const [Color(0xFF232B2B), Color(0xFF3B444B)];

      case 'squall':
      case 'tornado':
        return const [Color(0xFF0D2538), Color(0xFF1E3D59)];

      default:
        return const [Color(0xFF0F172A), Color(0xFF1E293B)];
    }
  }

  //////////////////// Dynamic Glowing Shape Colors ////////////////////
  static List<Color> getShapeColors(String? condition, {String? iconCode}) {
    if (condition == null) {
      return const [Colors.blueAccent, Colors.indigoAccent];
    }
    final isNight = iconCode?.contains('n') ?? false;
    // Night Moon Like Indigo Glow
    if (isNight) {
      return const [Colors.indigoAccent, Colors.deepPurpleAccent];
    }
    // Day Glowing Accent Orbs
    switch (condition.toLowerCase()) {
      case 'clear':
        return const [Colors.amber, Colors.lightBlueAccent]; // Sun glow

      case 'clouds':
        return const [Colors.blueGrey, Colors.cyan];

      case 'rain':
        return const [Colors.blueAccent, Colors.lightBlueAccent];

      case 'drizzle':
        return const [Colors.cyanAccent, Colors.blueAccent];

      case 'thunderstorm':
        return const [Colors.orangeAccent, Colors.purpleAccent];

      case 'snow':
        return const [Colors.white70, Colors.lightBlueAccent];

      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
        return const [Colors.grey, Colors.blueGrey];

      case 'squall':
      case 'tornado':
        return const [Colors.tealAccent, Colors.cyanAccent];

      default:
        return const [Colors.blueAccent, Colors.indigoAccent];
    }
  }
}
