import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

/// A custom BoxBorder that draws a gradient border around a widget.
///
/// This border allows you to specify a gradient and a width for the border.
/// It supports both rectangular and circular shapes.
class FlutterTagBorderGradient extends BoxBorder {
  /// The gradient used to paint the border.
  final Gradient gradient;

  /// The width of the border.
  /// The default value is 1.0.
  final double width;

  /// Creates a new instance of [FlutterTagBorderGradient].
  ///
  /// The [gradient] parameter is required and defines the color gradient of the border.
  /// The [width] parameter is optional and specifies the width of the border.
  const FlutterTagBorderGradient({
    required this.gradient,
    this.width = 1.0,
  });

  @override
  BorderSide get bottom => BorderSide.none;

  @override
  BorderSide get top => BorderSide.none;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  bool get isUniform => true;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    // Paints the border based on the shape provided.
    switch (shape) {
      case BoxShape.circle:
        // Circle shape does not support borderRadius.
        assert(borderRadius == null,
            'A borderRadius can only be given for rectangular boxes.');
        _paintCircle(canvas, rect);
        break;
      case BoxShape.rectangle:
        // Paints a rectangle with or without borderRadius.
        if (borderRadius != null) {
          _paintRectWithRadius(canvas, rect, borderRadius);
          return;
        }
        _paintRect(canvas, rect);
        break;
    }
  }

  /// Paints a rectangular border without rounded corners.
  void _paintRect(Canvas canvas, Rect rect) {
    final Paint paint = _getPaint(rect);
    // Create a rounded rectangle with the border width as the radius.
    final RRect rrect = RRect.fromRectAndRadius(
      rect.deflate(width / 2),
      Radius.circular(width / 2),
    );
    canvas.drawRRect(rrect, paint);
  }

  /// Paints a rectangular border with rounded corners as specified by [borderRadius].
  void _paintRectWithRadius(
      Canvas canvas, Rect rect, BorderRadius borderRadius) {
    final Paint paint = _getPaint(rect);
    // Convert BorderRadius to RRect and adjust for border width.
    final RRect rrect = borderRadius.toRRect(rect).deflate(width / 2);
    canvas.drawRRect(rrect, paint);
  }

  /// Paints a circular border.
  void _paintCircle(Canvas canvas, Rect rect) {
    final Paint paint = _getPaint(rect);
    // Calculate radius for the circle.
    final double radius = (rect.shortestSide - width) / 2.0;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  ShapeBorder scale(double t) {
    // Scales the border by a factor of [t].
    return FlutterTagBorderGradient(
      gradient: gradient,
      width: width * t,
    );
  }

  /// Creates a Paint object with the specified gradient and width.
  Paint _getPaint(Rect rect) {
    return Paint()
      ..strokeWidth = width
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke;
  }
}
