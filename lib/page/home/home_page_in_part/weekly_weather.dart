import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/riverpod/weather_riverpod.dart';
import '../../../custom_reuse/custom_three_layer/custom_blur_glass_effect.dart';
import '../../../custom_reuse/weather_basis_icon_or_color.dart';

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

        return CustomBlurGlassEffect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Weekly Forecast',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: dailyList.map((item) {
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

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dayName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                        Icon(
                          WeatherBasisIconOrColor.getIcon(
                            item.weather?[0].main,
                          ),
                          color: WeatherBasisIconOrColor.getColor(
                            item.weather?[0].main,
                          ),
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                ' ${item.main?.tempMin?.round() ?? 0}°',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Container(
                                  width: 50,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    gradient: const LinearGradient(
                                      colors: [Colors.blue, Colors.orange],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${item.main?.tempMax?.round() ?? 0}° ',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
