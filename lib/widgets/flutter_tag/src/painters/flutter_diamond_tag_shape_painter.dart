import 'package:flutter/material.dart';
import '../flutter_tag_gradient.dart';
import '../utils/flutter_gradient_utils.dart';

/// A custom painter for drawing a diamond-shaped tag with optional gradients and borders.
class FlutterDiamondTagShapePainter extends CustomPainter {
  /// The color used for the tag background when no gradient is provided.
  final Color color;

  /// Optional gradient for the tag background.
  final FlutterTagGradient? tagGradient;

  /// Optional gradient for the tag border.
  final FlutterTagGradient? borderGradient;

  /// Optional border specifications including color and width.
  final BorderSide? borderSide;

  /// Constructs a [FlutterDiamondTagShapePainter] with the given parameters.
  FlutterDiamondTagShapePainter({
    this.color = Colors.blue,
    this.tagGradient,
    this.borderGradient,
    this.borderSide,
  });

  @override
  void paint(Canvas canvas, Size size) {
    /// Create a paint object for the tag's fill color or gradient.
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..shader = tagGradient != null
          ? FlutterGradientUtils.getGradientShader(
              tagGradient: tagGradient!,
              width: size.width,
              height: size.height,
            )
          : null;

    /// Create a paint object for the tag's border color or gradient.
    final Paint paintBorder = Paint()
      ..color = borderSide?.color ?? Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderSide?.width ?? 0
      ..shader = borderGradient != null
          ? FlutterGradientUtils.getGradientShader(
              tagGradient: borderGradient!,
              width: size.width,
              height: size.height,
            )
          : null;

    /// Define the path for the diamond shape.
    final Path path = Path()
      ..moveTo(size.width / 2, 0)

      /// Top vertex
      ..lineTo(size.width, size.height / 2)

      /// Right vertex
      ..lineTo(size.width / 2, size.height)

      /// Bottom vertex
      ..lineTo(0, size.height / 2)

      /// Left vertex
      ..close();

    /// Close the path

    /// Draw the diamond shape with the tag paint.
    canvas.drawPath(path, paint);

    /// Draw the border if a border side is specified.
    if (borderSide != BorderSide.none) {
      canvas.drawPath(path, paintBorder);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    /// Redraw the painter when any of the properties change.
    return oldDelegate is FlutterDiamondTagShapePainter &&
        (color != oldDelegate.color ||
            tagGradient != oldDelegate.tagGradient ||
            borderGradient != oldDelegate.borderGradient ||
            borderSide != oldDelegate.borderSide);
  }
}
