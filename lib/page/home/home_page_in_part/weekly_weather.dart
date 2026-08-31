import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/riverpod/weather_riverpod.dart';
import '../../../custom_reuse/custom_three_layer/custom_blur_glass_effect.dart';
import '../../../custom_reuse/weather_basis_icon_or_color.dart';
import '../../../helper/temp_unit_converter.dart';

class WeeklyWeather extends ConsumerWidget {
  const WeeklyWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyWeather = ref.watch(forecastNotifierProvider);

    return weeklyWeather.when(
      data: (weekly) {
        final list = weekly?.list ?? [];

        final dailyList = list.where((item) {
          return item.dtTxt?.contains('12:00:00') ?? false;
        }).toList();

        final isCelsius = ref.watch(isCelsiusProvider);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),

              //////////////////// Main Heading ////////////////////
              child: const Text(
                'Weekly Forecast',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 8),

            CustomBlurGlassEffect(
              child: Column(
                children: dailyList.expand((item) {
                  final dateTime = DateTime.fromMillisecondsSinceEpoch(
                    (item.dt?.toInt() ?? 0) * 1000,
                  );

                  final dayName = DateFormat('EEEE').format(dateTime);

                  final rawDesc = item.weather?[0].description ?? '';

                  final description = rawDesc
                      .split(' ')
                      .map((word) {
                        return word.isNotEmpty
                            ? word[0].toUpperCase() + word.substring(1)
                            : '';
                      })
                      .join(' ');

                  final minTemp = TempUnitConverter.convert(
                    item.main?.tempMin,
                    isCelsius,
                  );
                  final maxTemp = TempUnitConverter.convert(
                    item.main?.tempMax,
                    isCelsius,
                  );

                  return [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //////////////////// Day Name ////////////////////
                                Text(
                                  dayName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 2),

                                //////////////////// Description ////////////////////
                                Text(
                                  description,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
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
                            size: 20,
                          ),

                          const SizedBox(width: 8),

                          //////////////////// Min Temp ////////////////////
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  ' $minTemp°',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                //////////////////// Grad Box ////////////////////
                                Expanded(
                                  child: Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.orange],
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                //////////////////// Max Temp ////////////////////
                                Text(
                                  '$maxTemp° ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (item != dailyList.last)
                      const Divider(color: Colors.white10, height: 16),
                  ];
                }).toList(),
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
