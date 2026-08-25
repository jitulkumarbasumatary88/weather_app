import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/riverpod/weather_riverpod.dart';
import '../../../custom_reuse/custom_three_layer/custom_blur_glass_effect.dart';

class SunRiseOrSetWeather extends ConsumerWidget {
  const SunRiseOrSetWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sunRiseOrSetWeather = ref.watch(weatherNotifierProvider);

    return sunRiseOrSetWeather.when(
      data: (sunRiseOrSet) {
        final sunriseTime = DateFormat('h:mm a').format(
          DateTime.fromMillisecondsSinceEpoch(
            (sunRiseOrSet?.sys?.sunrise?.toInt() ?? 0) * 1000,
          ),
        );

        final sunsetTime = DateFormat('h:mm a').format(
          DateTime.fromMillisecondsSinceEpoch(
            (sunRiseOrSet?.sys?.sunset?.toInt() ?? 0) * 1000,
          ),
        );

        return CustomBlurGlassEffect(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.wb_sunny_rounded,
                    color: Colors.amber,
                    size: 28,
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Sunrise',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),

                  Text(
                    sunriseTime,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              Container(width: 1, height: 40, color: Colors.white24),

              Column(
                children: [
                  const Icon(
                    Icons.nights_stay_rounded,
                    color: Colors.deepOrangeAccent,
                    size: 28,
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Sunset',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),

                  Text(
                    sunsetTime,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },

      loading: () => const SizedBox.shrink(),

      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
