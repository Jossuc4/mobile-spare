import 'dart:math';
import 'package:flutter/material.dart';

class GaugePainter extends CustomPainter {
  final double value;
  final double intercircleSize;
  final bool isDarkMode;
  final double plafond;

  GaugePainter(this.value, this.intercircleSize, this.isDarkMode, this.plafond);

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    String valueText = value.toStringAsFixed(1);
    double fontSize = valueText.length > 3 ? 45.0 : 35.0;

    final Paint backgroundPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          isDarkMode ? Colors.grey[300]! : Colors.grey[200]!,
          isDarkMode ? Colors.grey[300]! : Colors.grey[200]!,
        ],
      ).createShader(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 33.0
      ..strokeCap = StrokeCap.round;

    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
      colors: [
        isDarkMode ? const Color(0xFF36C18B) : const Color(0xFF36C18B),
        isDarkMode ? const Color(0xFF36C18B) : const Color(0xFF36C18B),
        isDarkMode ? const Color(0xFF00616C) : const Color(0xFF00616C),
      ],
    );

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 22.0
      ..strokeCap = StrokeCap.round;

    double sweepAngle = (value / plafond) * 2 * pi;

    final Paint shadowPaint = Paint()
      ..color = isDarkMode
          ? Colors.black.withOpacity(0.1)
          : Colors.black.withOpacity(0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    canvas.drawCircle(
      Offset(centerX + 5, centerY + 5),
      radius + 45.0,
      shadowPaint,
    );

    final Paint backgroundCirclePaint = Paint()
      ..color = isDarkMode ? Colors.grey[100]! : Colors.white
      ..style = PaintingStyle.fill;

    // Dessiner le cercle de fond
    canvas.drawCircle(
      Offset(centerX, centerY),
      radius + 40.0,
      backgroundCirclePaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      -pi,
      2 * pi,
      false,
      backgroundPaint,
    );

    final Paint linePaint = Paint()
      ..color = isDarkMode ? Colors.grey : Colors.grey
      ..strokeWidth = 1.0;

    int numLines = 35;
    double lineLength = 10;
    double lineOffset = -4;

    for (int i = 0; i < numLines; i++) {
      double angle = (-pi) + (i * (2 * pi / numLines));
      double startX = centerX + (radius - lineLength - lineOffset) * cos(angle);
      double startY = centerY + (radius - lineLength - lineOffset) * sin(angle);
      double endX = centerX + (radius - lineOffset) * cos(angle);
      double endY = centerY + (radius - lineOffset) * sin(angle);
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), linePaint);
    }

    // Dessiner l'arc de jauge
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      -pi,
      sweepAngle,
      false,
      progressPaint,
    );

    double endX = centerX + radius * cos(-pi + sweepAngle);
    double endY = centerY + radius * sin(-pi + sweepAngle);

    final Paint handlePaintOuter = Paint()
      ..color = isDarkMode ? Colors.white : Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(endX, endY), 20.0, handlePaintOuter);

    final Paint handlePaintInner = Paint()
      ..color = isDarkMode ? const Color(0xFF36C18B) : const Color(0xFF36C18B)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(endX, endY), 6.0, handlePaintInner);

    final Paint lightShadowPaint = Paint()
      ..color = isDarkMode
          ? Colors.white.withOpacity(0.8)
          : Colors.white.withOpacity(0.8)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    final Paint darkShadowPaint = Paint()
      ..color = isDarkMode
          ? Colors.black.withOpacity(0.2)
          : Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    canvas.drawCircle(
      Offset(centerX - 5, centerY - 5),
      intercircleSize,
      lightShadowPaint,
    );

    canvas.drawCircle(
      Offset(centerX + 5, centerY + 5),
      intercircleSize,
      darkShadowPaint,
    );

    final Paint intercirclePaint = Paint()
      ..color = isDarkMode ? Colors.grey[100]! : Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(centerX, centerY),
      intercircleSize,
      intercirclePaint,
    );

    // Ajouter le texte de la valeur animée au centre
    TextSpan valueSpan = TextSpan(
      style: TextStyle(
        color: isDarkMode ? Colors.black : Colors.black,
        fontSize: fontSize, // Utiliser la taille de police conditionnelle
        fontWeight: FontWeight.w400,
        letterSpacing: 1,
      ),
      text: valueText, // Utiliser le texte formaté
    );

    TextPainter valuePainter = TextPainter(
      text: valueSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    valuePainter.layout();
    valuePainter.paint(
      canvas,
      Offset(
          centerX - valuePainter.width / 2, centerY - valuePainter.height / 2),
    );

    TextSpan unitSpan = TextSpan(
      style: TextStyle(
        color: isDarkMode ? Colors.grey : Colors.grey,
        fontSize: 14.0,
      ),
      text: 'Wh', // Texte "Kwh"
    );

    TextPainter unitPainter = TextPainter(
      text: unitSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    unitPainter.layout();
    unitPainter.paint(
      canvas,
      Offset(centerX - unitPainter.width / 2,
          centerY + valuePainter.height / 2 + 5),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
