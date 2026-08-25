import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/riverpod/weather_riverpod.dart';
import '../../../custom_reuse/custom_three_layer/custom_blur_glass_effect.dart';

class GridWeather extends ConsumerWidget {
  const GridWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridWeather = ref.watch(weatherNotifierProvider);

    return gridWeather.when(
      data: (grid) {
        final visibilityKm = ((grid?.visibility ?? 0) / 1000).toStringAsFixed(
          1,
        );

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    'Humidity',
                    '${grid?.main?.humidity ?? 0}%',
                    Icons.water_drop_rounded,
                    Colors.lightBlueAccent,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricTile(
                    'Wind Speed',
                    '${grid?.wind?.speed ?? 0} m/s',
                    Icons.air_rounded,
                    Colors.cyanAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    'Feels Like',
                    '${grid?.main?.feelsLike?.round() ?? 0}°C',
                    Icons.thermostat_rounded,
                    Colors.pinkAccent,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricTile(
                    'Air Pressure',
                    '${grid?.main?.pressure ?? 0} hPa',
                    Icons.speed_rounded,
                    Colors.purpleAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    'Visibility',
                    '$visibilityKm km',
                    Icons.visibility_rounded,
                    Colors.greenAccent,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricTile(
                    'Cloudiness',
                    '${grid?.clouds?.all ?? 0}%',
                    Icons.cloud_rounded,
                    Colors.blueGrey.shade100,
                  ),
                ),
              ],
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),

    );
  }

  Widget _buildMetricTile(
    String title,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return CustomBlurGlassEffect(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 18),
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
