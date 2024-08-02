import 'package:flutter/material.dart';

import '../flutter_tag_gradient.dart';
import '../utils/flutter_gradient_utils.dart';

class FlutterPentagonTagShapePainter extends CustomPainter {
  final Color color;

  /// Base color for the tag
  final FlutterTagGradient? tagGradient;

  /// Gradient for the tag
  final FlutterTagGradient? borderGradient;

  /// Gradient for the border
  final BorderSide? borderSide;

  /// Border properties

  /// Creates a [FlutterPentagonTagShapePainter] instance.
  FlutterPentagonTagShapePainter({
    this.color = Colors.green,
    this.tagGradient,
    this.borderGradient,
    this.borderSide,
  });

  @override
  void paint(Canvas canvas, Size size) {
    /// Paint object for the tag background
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..shader = tagGradient != null
          ? FlutterGradientUtils.getGradientShader(
              tagGradient: tagGradient!,
              width: size.width,
              height: size.height,
            )
          : null;

    /// Paint object for the tag border
    final paintBorder = Paint()
      ..color = borderSide?.color ?? Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderSide?.width ?? 0
      ..shader = borderGradient != null
          ? FlutterGradientUtils.getGradientShader(
              tagGradient: borderGradient!,
              width: size.width,
              height: size.height,
            )
          : null;

    /// Create a Path for the pentagon shape
    final path = Path()
      ..moveTo(size.width / 2, 0)

      /// Top vertex
      ..lineTo(size.width, size.height * 0.38)

      /// Right top vertex
      ..lineTo(size.width * 0.82, size.height)

      /// Bottom right vertex
      ..lineTo(size.width * 0.18, size.height)

      /// Bottom left vertex
      ..lineTo(0, size.height * 0.38)

      /// Left top vertex
      ..close();

    /// Close the path to form the pentagon

    /// Draw the tag background
    canvas.drawPath(path, paint);

    /// Draw the border if borderSide is specified
    if (borderSide != BorderSide.none) {
      canvas.drawPath(path, paintBorder);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    /// Only repaint if properties change
    return oldDelegate is FlutterPentagonTagShapePainter &&
        (color != oldDelegate.color ||
            tagGradient != oldDelegate.tagGradient ||
            borderGradient != oldDelegate.borderGradient ||
            borderSide != oldDelegate.borderSide);
  }
}
