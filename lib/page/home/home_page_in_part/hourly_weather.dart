import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/riverpod/weather_riverpod.dart';
import '../../../custom_reuse/custom_three_layer/custom_blur_glass_effect.dart';
import '../../../custom_reuse/weather_basis_icon_or_color.dart';

class HourlyWeather extends ConsumerWidget {
  const HourlyWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hourlyWeather = ref.watch(forecastNotifierProvider);

    return hourlyWeather.when(
      data: (hourly) {
        final list = hourly?.list?.take(8).toList() ?? [];

        return CustomBlurGlassEffect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hourly Forecast',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
          
                    final dateTime = DateTime.fromMillisecondsSinceEpoch(
                      (item.dt?.toInt() ?? 0) * 1000,
                    );
          
                    final timeString = DateFormat('h a').format(dateTime);
          
                    return Container(
                      width: 70,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            timeString,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Icon(
                            WeatherBasisIconOrColor.getIcon(
                              item.weather?[0].main,
                            ),
                            color: WeatherBasisIconOrColor.getColor(
                              item.weather?[0].main,
                            ),
                            size: 18,
                          ),
                          Text(
                            '${item.main?.temp?.round() ?? 0}°C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
