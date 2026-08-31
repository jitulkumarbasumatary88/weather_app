import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/riverpod/weather_riverpod.dart';
import 'package:weather_app/helper/temp_unit_converter.dart';
import '../../../custom_reuse/custom_three_layer/custom_blur_glass_effect.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: const Text(
                'Temperature Trend',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 8),

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

                    final dateTime = DateTime.fromMillisecondsSinceEpoch(
                      (item.dt?.toInt() ?? 0) * 1000,
                    );

                    final timeStr = DateFormat('h a').format(dateTime);

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
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
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
