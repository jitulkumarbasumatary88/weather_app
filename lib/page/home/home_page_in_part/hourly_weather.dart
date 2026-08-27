import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/riverpod/weather_riverpod.dart';
import '../../../custom_reuse/weather_basis_icon_or_color.dart';

class HourlyWeather extends ConsumerWidget {
  const HourlyWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hourlyWeather = ref.watch(forecastNotifierProvider);

    return hourlyWeather.when(
      data: (hourly) {
        final list = hourly?.list?.take(8).toList() ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),

              //////////////////// Main Heading ////////////////////
              child: const Text(
                'Hourly Forecast',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              height: 140,
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
                    width: 90,
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1), // 0.08
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //////////////////// Time ////////////////////
                        Text(
                          timeString,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        //////////////////// Icon ////////////////////
                        Icon(
                          WeatherBasisIconOrColor.getIcon(
                            item.weather?[0].main,
                          ),
                          color: WeatherBasisIconOrColor.getColor(
                            item.weather?[0].main,
                          ),
                          size: 32,
                        ),

                        //////////////////// Temp ////////////////////
                        Text(
                          '${item.main?.temp?.round() ?? 0}°C',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
