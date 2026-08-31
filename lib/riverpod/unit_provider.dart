import 'package:flutter_riverpod/flutter_riverpod.dart';

//////////////////// Temperature Unit Provider (°C ya °F) ////////////////////
// true = Celsius (°C) default, false = Fahrenheit (°F)
final isCelsiusProvider = StateProvider<bool>((ref) => true);

//////////////////// Temperature Conversion Helper ////////////////////
class TempHelper {
  // Celsius temperature ko user ke selected unit (°C ya °F) me convert karta hai
  static int convert(num? celsiusTemp, bool isCelsius) {
    if (celsiusTemp == null) return 0;

    // Agar Celsius select hai toh direct round karke return karo
    if (isCelsius) {
      return celsiusTemp.round();
    } else {
      // Agar Fahrenheit select hai toh formula: (Celsius * 9/5) + 32 se convert karo
      return ((celsiusTemp * 9 / 5) + 32).round();
    }
  }

  // Current selected unit ka symbol ('°C' ya '°F') return karta hai
  static String unit(bool isCelsius) {
    return isCelsius ? '°C' : '°F';
  }
}
