import 'dart:math';
import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  final double waveHeight;
  final double waveOffset;

  WaveClipper(this.waveHeight, this.waveOffset);

  @override
  Path getClip(Size size) {
    final path = Path();
    final double height = size.height * waveHeight;

    path.lineTo(0.0, size.height - height);

    for (double x = 0; x <= size.width; x += 10) {
      final double y = 30 * sin(waveOffset + (x / size.width) * 2 * pi);
      path.lineTo(x, size.height - height + y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
