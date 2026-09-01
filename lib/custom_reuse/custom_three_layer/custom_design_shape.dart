import 'package:flutter/material.dart';
import '../weather_basis_icon_or_color.dart';

class CustomDesignShape extends StatelessWidget {
  final String? condition;
  final String? iconCode;

  const CustomDesignShape({super.key, this.condition, this.iconCode});

  @override
  Widget build(BuildContext context) {
    // Glowing Orbs Dynamic Colors
    final shapeColors = WeatherBasisIconOrColor.getShapeColors(
      condition,
      iconCode: iconCode,
    );

    return SizedBox.expand(
      child: Stack(
        children: [
          // Top Right Glowing Orb (Sun / Moon Glow effect)
          Positioned(
            top: -50,
            right: -50,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: shapeColors[0].withValues(alpha: 0.35),
              ),
            ),
          ),

          // Bottom Left Ambient Glow Orb
          Positioned(
            bottom: 100,
            left: -60,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: shapeColors.length > 1
                    ? shapeColors[1].withValues(alpha: 0.25)
                    : shapeColors[0].withValues(alpha: 0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
