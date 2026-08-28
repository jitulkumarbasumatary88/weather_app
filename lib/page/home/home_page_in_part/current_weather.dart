import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/custom_reuse/custom_three_layer/custom_blur_glass_effect.dart';
import 'package:weather_app/riverpod/weather_riverpod.dart';
import '../../../custom_reuse/weather_basis_icon_or_color.dart';

class CurrentWeather extends ConsumerWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherNotifierProvider);

    return currentWeather.when(
      data: (current) {
        if (current == null) return const SizedBox.shrink();

        final rawDesc = current.weather?[0].description ?? '';

        final description = rawDesc
            .split(' ')
            .map((word) {
              return word.isNotEmpty
                  ? word[0].toUpperCase() + word.substring(1)
                  : '';
            })
            .join(' ');

        return CustomBlurGlassEffect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //////////////////// Top ROW ////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    //////////////////// City Name ////////////////////
                    child: Text(
                      '${current.name ?? ''}, ${current.sys?.country ?? ''}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  //////////////////// Switch Button ////////////////////
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: const Text(
                      'Switch to °F',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              //////////////////// MIDDLE ROW ////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //////////////////// Main Temp ////////////////////
                            Text(
                              '${current.main?.temp?.round() ?? 0}',
                              style: const TextStyle(
                                fontSize: 84,
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                                height: 1.0,
                              ),
                            ),

                            //////////////////// Temp Degree°C ////////////////////
                            const Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                '°C',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        //////////////////// Description ////////////////////
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //////////////////// Weather Icon ////////////////////
                  Container(
                    // color: Colors.red,
                    width: 120,
                    height: 120,
                    alignment: Alignment.center,
                    child: Icon(
                      WeatherBasisIconOrColor.getIcon(current.weather?[0].main),
                      color: WeatherBasisIconOrColor.getColor(
                        current.weather?[0].main,
                      ),
                      size: 72,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              //////////////////// Divider ////////////////////
              const Divider(color: Colors.white12, height: 1),

              const SizedBox(height: 16),

              //////////////////// Bottom Three Item ////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildThreeDownItem(
                    icon: Icons.arrow_downward_rounded,
                    iconColor: Colors.lightBlueAccent,
                    label: 'Low',
                    value: '${current.main?.tempMin?.round() ?? 0}°',
                  ),

                  _buildThreeDownItem(
                    icon: Icons.arrow_upward_rounded,
                    iconColor: Colors.orangeAccent,
                    label: 'High',
                    value: '${current.main?.tempMax?.round() ?? 0}°',
                  ),

                  _buildThreeDownItem(
                    icon: Icons.thermostat_rounded,
                    iconColor: Colors.pinkAccent,
                    label: 'Feels Like',
                    value: '${current.main?.feelsLike?.round() ?? 0}°',
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

  //////////////////// Bottom Three Item ////////////////////
  Widget _buildThreeDownItem({
    required IconData icon,
    required MaterialAccentColor iconColor,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: iconColor),

            const SizedBox(width: 4),

            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
