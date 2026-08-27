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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),

              //////////////////// Main Heading ////////////////////
              child: const Text(
                'Weather Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 8),

            //////////////////// Humidity / Wind ////////////////////
            Row(
              children: [
                Expanded(
                  child: _buildGridView(
                    title: 'Humidity',
                    value: '${grid?.main?.humidity ?? 0}%',
                    icon: Icons.water_drop_rounded,
                    iconColor: Colors.lightBlueAccent,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _buildGridView(
                    title: 'Wind Speed',
                    value: '${grid?.wind?.speed ?? 0} m/s',
                    icon: Icons.air_rounded,
                    iconColor: Colors.cyanAccent,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            //////////////////// Feel / Air ////////////////////
            Row(
              children: [
                Expanded(
                  child: _buildGridView(
                    title: 'Feels Like',
                    value: '${grid?.main?.feelsLike?.round() ?? 0}°C',
                    icon: Icons.thermostat_rounded,
                    iconColor: Colors.pinkAccent,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _buildGridView(
                    title: 'Air Pressure',
                    value: '${grid?.main?.pressure ?? 0} hPa',
                    icon: Icons.speed_rounded,
                    iconColor: Colors.purpleAccent,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            //////////////////// Visibility / Cloud ////////////////////
            Row(
              children: [
                Expanded(
                  child: _buildGridView(
                    title: 'Visibility',
                    value: '$visibilityKm km',
                    icon: Icons.visibility_rounded,
                    iconColor: Colors.greenAccent,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _buildGridView(
                    title: 'Cloudiness',
                    value: '${grid?.clouds?.all ?? 0}%',
                    icon: Icons.cloud_rounded,
                    iconColor: Colors.blueGrey.shade100,
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

  //////////////////// Grid View ////////////////////
  Widget _buildGridView({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return CustomBlurGlassEffect(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 22),

              const SizedBox(width: 6),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
