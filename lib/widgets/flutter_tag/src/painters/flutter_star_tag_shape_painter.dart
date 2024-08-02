import 'package:flutter/material.dart';

import '../flutter_tag_gradient.dart';
import '../utils/flutter_gradient_utils.dart';

class FlutterStarTagShapePainter extends CustomPainter {
  /// Color of the tag
  final Color color;

  /// Gradient for the tag fill
  final FlutterTagGradient? tagGradient;

  /// Gradient for the border
  final FlutterTagGradient? borderGradient;

  /// Border side properties including color and width
  final BorderSide? borderSide;

  FlutterStarTagShapePainter({
    this.color = Colors.blue,
    this.tagGradient,
    this.borderGradient,
    this.borderSide,
  });

  @override
  void paint(Canvas canvas, Size size) {
    /// Create the path for a star shape
    final path = Path()
      ..moveTo(size.width * 0.14, size.height * 0.14)

      /// Starting point of the path
      ..lineTo(size.width * 0.3, size.height * 0.14)

      /// Draw line to top right
      ..lineTo(size.width * 0.385, 0)

      /// Draw line to the top point
      ..lineTo(size.width * 0.515, size.height * 0.08)

      /// Draw line to the right top point
      ..lineTo(size.width * 0.627, size.height * 0.012)

      /// Draw line to the right top point
      ..lineTo(size.width * 0.7, size.height * 0.134)

      /// Draw line to bottom right
      ..lineTo(size.width * 0.867, size.height * 0.134)

      /// Draw line to bottom right
      ..lineTo(size.width * 0.867, size.height * 0.3)

      /// Draw line to middle right
      ..lineTo(size.width, size.height * 0.38)

      /// Draw line to middle
      ..lineTo(size.width * 0.922, size.height * 0.505)

      /// Draw line to left middle
      ..lineTo(size.width * 0.995, size.height * 0.629)

      /// Draw line to left bottom
      ..lineTo(size.width * 0.866, size.height * 0.706)

      /// Draw line to bottom left
      ..lineTo(size.width * 0.866, size.height * 0.868)

      /// Draw line to bottom left
      ..lineTo(size.width * 0.697, size.height * 0.868)

      /// Draw line to bottom left
      ..lineTo(size.width * 0.618, size.height * 0.996)

      /// Draw line to bottom
      ..lineTo(size.width * 0.5, size.height * 0.924)

      /// Draw line to center
      ..lineTo(size.width * 0.379, size.height * 0.996)

      /// Draw line to top left
      ..lineTo(size.width * 0.302, size.height * 0.868)

      /// Draw line to top left
      ..lineTo(size.width * 0.14, size.height * 0.868)

      /// Draw line to bottom left
      ..lineTo(size.width * 0.14, size.height * 0.702)

      /// Draw line to bottom left
      ..lineTo(size.width * 0.004, size.height * 0.618)

      /// Draw line to bottom left
      ..lineTo(size.width * 0.08, size.height * 0.494)

      /// Draw line to bottom left
      ..lineTo(size.width * 0.012, size.height * 0.379)

      /// Draw line to bottom left
      ..lineTo(size.width * 0.14, size.height * 0.306)

      /// Draw line to bottom left
      ..close();

    /// Close the path

    /// Paint for the tag fill
    final paint = Paint()
      ..color = color

      /// Set the color
      ..shader = tagGradient != null
          ? FlutterGradientUtils.getGradientShader(
              tagGradient: tagGradient!,
              width: size.width,
              height: size.height,
            )
          : null;

    /// Apply gradient shader if provided

    /// Paint for the border
    final paintBorder = Paint()
      ..color = borderSide?.color ?? Colors.white

      /// Set border color
      ..style = PaintingStyle.stroke

      /// Set paint style to stroke
      ..strokeCap = StrokeCap.round

      /// Set stroke cap
      ..strokeWidth = borderSide?.width ?? 0

      /// Set stroke width
      ..shader = borderGradient != null
          ? FlutterGradientUtils.getGradientShader(
              tagGradient: borderGradient!,
              width: size.width,
              height: size.height,
            )
          : null;

    /// Apply gradient shader if provided

    /// Draw the tag shape
    canvas.drawPath(path, paint);

    /// Draw the border if a border is defined
    if (borderSide != null && borderSide != BorderSide.none) {
      canvas.drawPath(path, paintBorder);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    /// Redraw the tag if any property has changed
    return oldDelegate is FlutterStarTagShapePainter &&
        (color != oldDelegate.color ||
            tagGradient != oldDelegate.tagGradient ||
            borderGradient != oldDelegate.borderGradient ||
            borderSide != oldDelegate.borderSide);
  }
}
