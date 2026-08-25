import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${current.name ?? ''}, ${current.sys?.country ?? ''}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 50),

                  Icon(
                    WeatherBasisIconOrColor.getIcon(current.weather?[0].main),
                    color: WeatherBasisIconOrColor.getColor(
                      current.weather?[0].main,
                    ),
                    size: 70,
                  ),

                  // const SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${current.main?.temp?.round() ?? 0}',
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          '°C',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  // const SizedBox(height: 5),

                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  // Widget _buildThreeDownItem({
  //   required IconData icon,
  //   required Color iconColor,
  //   required String label,
  //   required String value,
  // }) {
  //   return Column(
  //     children: [
  //       Row(
  //         // mainAxisSize: MainAxisSize.min,
  //         // mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(icon, size: 14, color: iconColor),
  //
  //           const SizedBox(width: 5),
  //
  //           Text(
  //             label,
  //             style: const TextStyle(color: Colors.white, fontSize: 12),
  //           ),
  //         ],
  //       ),
  //
  //       const SizedBox(height: 5),
  //
  //       Text(
  //         value,
  //         // textAlign: TextAlign.center,
  //         style: const TextStyle(
  //           color: Colors.white,
  //           fontWeight: FontWeight.bold,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildThreeDownItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 📍 Top Line: Icon + Label
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: iconColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),

        const SizedBox(height: 5),

        // 📍 Bottom Line: Centered Temperature Value
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }


}
