import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/riverpod/weather_riverpod.dart';
import '../weather_basis_icon_or_color.dart';

class CustomDesignShape extends ConsumerWidget {
  const CustomDesignShape({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customDesignShape = ref.watch(weatherNotifierProvider);
    return customDesignShape.when(
      data: (designShape) {
        final condition = designShape?.weather?[0].main;
        final baseColor = WeatherBasisIconOrColor.getColor(condition);

        return Positioned(
          top: 50,
          right: 45,
          child: Icon(
            WeatherBasisIconOrColor.getIcon(condition),
            color: baseColor.withValues(alpha: 0.3),
            size: 300,
          ),
        );
      },

      loading: () => const SizedBox.shrink(),

      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
