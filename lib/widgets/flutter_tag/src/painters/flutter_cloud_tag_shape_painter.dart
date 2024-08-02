import 'package:flutter/material.dart';
import '../flutter_tag_gradient.dart';
import '../utils/flutter_gradient_utils.dart';

/// A custom painter for drawing a cloud-shaped tag.
class FlutterCloudTagShapePainter extends CustomPainter {
  /// The color used to paint the tag's fill.
  final Color color;

  /// Optional gradient for the tag's fill. If provided, it will override [color].
  final FlutterTagGradient? tagGradient;

  /// Optional gradient for the tag's border. If provided, it will be used instead of a solid color border.
  final FlutterTagGradient? borderGradient;

  /// Optional border side configuration. Defines the border's color, width, and style.
  final BorderSide? borderSide;

  /// Constructs a [FlutterCloudTagShapePainter] with optional parameters for customization.
  FlutterCloudTagShapePainter({
    this.color = Colors.blue,
    this.tagGradient,
    this.borderGradient,
    this.borderSide,
  });

  @override
  void paint(Canvas canvas, Size size) {
    /// Paint object for the tag's fill
    final Paint paint = Paint()
      ..color = color

      /// Set the fill color
      ..shader = tagGradient != null
          ? FlutterGradientUtils.getGradientShader(
              tagGradient: tagGradient!,
              width: size.width,
              height: size.height,
            )
          : null;

    /// Apply gradient if provided

    /// Paint object for the tag's border
    final Paint paintBorder = Paint()
      ..color = borderSide?.color ?? Colors.white

      /// Set the border color
      ..style = PaintingStyle.stroke

      /// Define the painting style as stroke
      ..strokeCap = StrokeCap.round

      /// Set the stroke cap to round
      ..strokeWidth = borderSide?.width ?? 0

      /// Set the stroke width
      ..shader = borderGradient != null
          ? FlutterGradientUtils.getGradientShader(
              tagGradient: borderGradient!,
              width: size.width,
              height: size.height,
            )
          : null;

    /// Apply gradient if provided

    /// Define the path for the cloud-shaped tag
    final Path path = Path()
      ..moveTo(size.width * 0.357, size.height * 0.156)
      ..arcToPoint(Offset(size.width * 0.643, size.height * 0.156),
          radius: Radius.circular(size.height * 0.157))

      /// Top-right arc
      ..arcToPoint(Offset(size.width * 0.847, size.height * 0.396),
          radius: Radius.circular(size.height * 0.165))

      /// Right-side arc
      ..arcToPoint(Offset(size.width * 0.857, size.height * 0.666),
          radius: Radius.circular(size.height * 0.170))

      /// Bottom-right arc
      ..arcToPoint(Offset(size.width * 0.643, size.height * 0.844),
          radius: Radius.circular(size.height * 0.163))

      /// Bottom-side arc
      ..arcToPoint(Offset(size.width * 0.357, size.height * 0.844),
          radius: Radius.circular(size.height * 0.157))

      /// Bottom-left arc
      ..arcToPoint(Offset(size.width * 0.145, size.height * 0.665),
          radius: Radius.circular(size.height * 0.163))

      /// Left-side arc
      ..arcToPoint(Offset(size.width * 0.154, size.height * 0.372),
          radius: Radius.circular(size.height * 0.170))

      /// Top-left arc
      ..arcToPoint(Offset(size.width * 0.357, size.height * 0.156),
          radius: Radius.circular(size.height * 0.163));

    /// Complete the path by connecting back to the start

    /// Draw the tag's shape
    canvas.drawPath(path, paint);

    /// Draw the border if a border side is defined
    if (borderSide != BorderSide.none) {
      canvas.drawPath(path, paintBorder);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    /// Always repaint if the parameters change
    return true;
  }
}
