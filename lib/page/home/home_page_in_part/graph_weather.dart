import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/riverpod/weather_riverpod.dart';
import 'package:weather_app/helper/temp_unit_converter.dart';
import '../../../custom_reuse/custom_three_layer/custom_blur_glass_effect.dart';
import '../../../helper/city_timezone.dart';

class GraphWeather extends ConsumerWidget {
  const GraphWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graphWeather = ref.watch(forecastNotifierProvider);

    return graphWeather.when(
      data: (graph) {
        final list = graph?.list?.take(8).toList() ?? [];

        final isCelsius = ref.watch(isCelsiusProvider);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //////////////////// Main Heading ////////////////////
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: const Text(
                'Temperature Trend',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            CustomBlurGlassEffect(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: list.map((item) {
                    final temp = item.main?.temp?.round() ?? 0;

                    final timeStr = formatCityHour(
                      item.dt,
                      graph?.city?.timezone,
                    );

                    final barHeight = (temp * 1.7).clamp(20.0, 60.0);

                    final graphTemp = TempUnitConverter.convert(
                      item.main?.temp,
                      isCelsius,
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //////////////////// Temp ////////////////////
                          Text(
                            '$graphTemp°',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 10),

                          //////////////////// Bar ////////////////////
                          Container(
                            width: 10,
                            height: barHeight,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.amber, Colors.orange],
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),

                          const SizedBox(height: 10),

                          //////////////////// Time ////////////////////
                          Text(
                            timeStr,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
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
