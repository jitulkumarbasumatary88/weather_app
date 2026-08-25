import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/riverpod/weather_riverpod.dart';
import '../../../custom_reuse/custom_three_layer/custom_blur_glass_effect.dart';

class GraphWeather extends ConsumerWidget {
  const GraphWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graphWeather = ref.watch(forecastNotifierProvider);

    return graphWeather.when(
      data: (graph) {
        final list = graph?.list?.take(8).toList() ?? [];

        return CustomBlurGlassEffect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Temperature Graph',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: list.map((item) {
                  final temp = item.main?.temp?.round() ?? 0;
          
                  final dateTime = DateTime.fromMillisecondsSinceEpoch(
                    (item.dt?.toInt() ?? 0) * 1000,
                  );
          
                  final timeStr = DateFormat('h a').format(dateTime);
                  final barHeight = (temp * 1.8).clamp(20.0, 60.0);
          
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '$temp°',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
          
                      const SizedBox(height: 6),
          
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
          
                      const SizedBox(height: 8),
          
                      Text(
                        timeStr,
                        style: const TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  );
                }).toList(),
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
