import 'package:flutter_riverpod/flutter_riverpod.dart';

final isCelsiusProvider = StateProvider<bool>((ref) => true);

class TempUnitConverter {
  static String unit(bool isCelsius) {
    return isCelsius ? '°C' : '°F';
  }

  static int convert(num? celsiusTemp, bool isCelsius) {
    if (celsiusTemp == null) return 0;

    if (isCelsius) {
      return celsiusTemp.round();
    } else {
      return ((celsiusTemp * 9 / 5) + 32).round();
    }
  }
}
