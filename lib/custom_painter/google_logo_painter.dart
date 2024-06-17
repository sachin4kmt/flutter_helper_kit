
import 'package:flutter/material.dart';

/// A widget that displays the Google logo using CustomPaint.
///
/// This widget renders the Google logo using a CustomPaint widget. It provides
/// a customizable size property to adjust the dimensions of the rendered logo.
///
/// Example usage:
/// ```dart
/// GoogleLogoWidget(
///   size: 48, // Specifies the size of the logo (in logical pixels)
/// )
/// ```
class GoogleLogoWidget extends StatelessWidget {
  /// The size of the Google logo.
  ///
  /// If [size] is not specified, it defaults to 24 logical pixels.
  final double? size;

  /// Creates a GoogleLogoWidget.
  ///
  /// The [size] parameter specifies the size of the Google logo. If not
  /// provided, it defaults to 24 logical pixels.
  const GoogleLogoWidget({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GoogleLogoPainter(),
      size: Size(
        size?.toDouble() ?? 24, // Converts size to double or defaults to 24
        size?.toDouble() ?? 24, // Converts size to double or defaults to 24
      ),
    );
  }
}

/// A CustomPainter that draws the Google logo.
///
/// This class implements the CustomPainter interface to draw the Google logo
/// using a series of arcs and rectangles. It handles the painting logic for
/// rendering the logo on a canvas of specified size.
class _GoogleLogoPainter extends CustomPainter {
  @override
  bool shouldRepaint(_) => true;

  @override
  void paint(Canvas canvas, Size size) {
    // Define drawing parameters
    final double length = size.width;
    final double verticalOffset = (size.height / 2) - (length / 2);
    final Rect bounds = Offset(0, verticalOffset) & Size.square(length);
    final Offset center = bounds.center;
    final double arcThickness = size.width / 4.5;
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = arcThickness;

    // Helper function to draw each arc
    void drawArc(double startAngle, double sweepAngle, Color color) {
      final Paint paint2 = paint..color = color;
      canvas.drawArc(bounds, startAngle, sweepAngle, false, paint2);
    }

    // Draw each arc segment of the Google logo
    drawArc(3.5, 1.9, Colors.red);
    drawArc(2.5, 1.0, Colors.amber);
    drawArc(0.9, 1.6, Colors.green.shade600);
    drawArc(-0.18, 1.5, Colors.blue.shade600);

    // Draw the rectangle part of the Google logo
    canvas.drawRect(
      Rect.fromLTRB(
        center.dx,
        center.dy - (arcThickness / 2),
        bounds.centerRight.dx + (arcThickness / 2) - 2,
        bounds.centerRight.dy + (arcThickness / 3),
      ),
      paint
        ..color = Colors.blue.shade600
        ..style = PaintingStyle.fill
        ..strokeWidth = 0,
    );
  }
}