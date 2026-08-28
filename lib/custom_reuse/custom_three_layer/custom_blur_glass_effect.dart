import 'package:flutter/material.dart';
import 'dart:ui';

class CustomBlurGlassEffect extends StatelessWidget {
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final BoxBorder? border;

  const CustomBlurGlassEffect({
    super.key,
    required this.child,
    this.width,
    this.padding,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? 20.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: width ?? double.infinity,
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.1),
                Colors.white.withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(radius),
            border:
                border ??
                Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 0, // 1.5
                ),
          ),
          child: child,
        ),
      ),
    );
  }
}
