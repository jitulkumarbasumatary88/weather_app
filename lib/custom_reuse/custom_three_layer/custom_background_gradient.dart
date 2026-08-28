import 'package:flutter/material.dart';

class CustomBackgroundGradient extends StatelessWidget {
  const CustomBackgroundGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0F172A),
            Color(0xFF1E293B), // 0xFF1E3C72
          ],
        ),
      ),
    );
  }
}
