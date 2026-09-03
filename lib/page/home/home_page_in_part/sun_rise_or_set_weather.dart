import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/riverpod/weather_riverpod.dart';
import '../../../custom_reuse/custom_three_layer/custom_blur_glass_effect.dart';
import '../../../helper/city_timezone.dart';

class SunRiseOrSetWeather extends ConsumerWidget {
  const SunRiseOrSetWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sunRiseOrSetWeather = ref.watch(weatherNotifierProvider);

    return sunRiseOrSetWeather.when(
      data: (sunRiseOrSet) {
        final sunriseTime = formatCityTime(
          sunRiseOrSet?.sys?.sunrise,
          sunRiseOrSet?.timezone,
        );

        final sunsetTime = formatCityTime(
          sunRiseOrSet?.sys?.sunset,
          sunRiseOrSet?.timezone,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //////////////////// Main Heading ////////////////////
              child: const Text(
                'Sunrise & Sunset',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            CustomBlurGlassEffect(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //////////////////// Icon ////////////////////
                      const Icon(
                        Icons.wb_sunny_rounded,
                        color: Colors.amber,
                        size: 26,
                      ),

                      const SizedBox(height: 6),

                      //////////////////// Sun Rise ////////////////////
                      Text(
                        'Sunrise',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 2),

                      //////////////////// Sun Rise Time ////////////////////
                      Text(
                        sunriseTime,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  //////////////////// Vertical Line ////////////////////
                  Container(width: 1, height: 50, color: Colors.white10),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //////////////////// Icon ////////////////////
                      const Icon(
                        Icons.nights_stay_rounded,
                        color: Colors.deepOrangeAccent,
                        size: 26,
                      ),

                      const SizedBox(height: 6),

                      //////////////////// Sun Set ////////////////////
                      Text(
                        'Sunset',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 2),

                      //////////////////// Sun Set Time ////////////////////
                      Text(
                        sunsetTime,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },

      loading: () => const SizedBox.shrink(),

      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
