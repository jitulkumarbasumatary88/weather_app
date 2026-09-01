import 'package:flutter/material.dart';
import '../weather_basis_icon_or_color.dart';

class CustomBackgroundGradient extends StatelessWidget {
  final String? condition;
  final String? iconCode;

  const CustomBackgroundGradient({super.key, this.condition, this.iconCode});

  @override
  Widget build(BuildContext context) {
    // Weather Condition Day/Night Colors Get
    final colors = WeatherBasisIconOrColor.getBackgroundGradient(
      condition,
      iconCode: iconCode,
    );

    // Smooth Transition AnimatedContainer
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
        ),
      ),
    );
  }
}
