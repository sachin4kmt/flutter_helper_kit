import 'dart:math';

import 'package:flutter/material.dart';

import '../flutter_tag_gradient.dart';
import '../utils/flutter_gradient_utils.dart';

class FlutterHexagonTagShapePainter extends CustomPainter {
  final Color color;
  final FlutterTagGradient? tagGradient;
  final FlutterTagGradient? borderGradient;
  final BorderSide? borderSide;

  FlutterHexagonTagShapePainter({
    this.color = Colors.green,
    this.tagGradient,
    this.borderGradient,
    this.borderSide,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..shader = tagGradient != null
          ? FlutterGradientUtils.getGradientShader(
              tagGradient: tagGradient!,
              width: size.width,
              height: size.height,
            )
          : null;

    final paintBorder = Paint()
      ..color = borderSide?.color ?? Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderSide?.width ?? 0
      ..shader = borderGradient != null
          ? FlutterGradientUtils.getGradientShader(
              tagGradient: borderGradient!,
              width: size.width,
              height: size.height,
            )
          : null;

    final path = Path();
    final double width = size.width;
    final double height = size.height;
    final double radius = min(width, height) / 2;
    const double angle = pi / 3;

    for (int i = 0; i < 6; i++) {
      final double x = radius * cos(i * angle) + width / 2;
      final double y = radius * sin(i * angle) + height / 2;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
    if (borderSide != BorderSide.none) {
      canvas.drawPath(path, paintBorder);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
