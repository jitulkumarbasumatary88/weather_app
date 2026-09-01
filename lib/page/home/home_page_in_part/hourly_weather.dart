import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/custom_reuse/custom_three_layer/custom_blur_glass_effect.dart';
import 'package:weather_app/riverpod/weather_riverpod.dart';
import 'package:weather_app/helper/temp_unit_converter.dart';
import '../../../custom_reuse/weather_basis_icon_or_color.dart';

class HourlyWeather extends ConsumerWidget {
  const HourlyWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hourlyWeather = ref.watch(forecastNotifierProvider);

    final isCelsius = ref.watch(isCelsiusProvider);

    return hourlyWeather.when(
      data: (hourly) {
        final list = hourly?.list?.take(8).toList() ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),

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

            CustomBlurGlassEffect(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Row(
                  children: list.map((item) {
                    final dateTime = DateTime.fromMillisecondsSinceEpoch(
                      (item.dt?.toInt() ?? 0) * 1000,
                    );

                    final timeString = DateFormat('h a').format(dateTime);

                    final hourlyTemp = TempUnitConverter.convert(
                      item.main?.temp,
                      isCelsius,
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
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

                          const SizedBox(height: 10),

                          //////////////////// Icon ////////////////////
                          Icon(
                            WeatherBasisIconOrColor.getIcon(
                              item.weather?[0].main,
                            ),
                            color: WeatherBasisIconOrColor.getColor(
                              item.weather?[0].main,
                            ),
                            size: 22,
                          ),

                          const SizedBox(height: 10),

                          //////////////////// Temp ////////////////////
                          Text(
                            '$hourlyTemp°',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
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
