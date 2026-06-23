import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/app_responsive/app_responsive.dart';
import 'package:flutter_helper_kit/extensions/color/color_extension.dart';

class CenterTextDivider extends CustomPainter {
  final InlineSpan content;
  final Color lineColor;
  final double thickness;
  final double spacing;
  final double lineWidth;

  CenterTextDivider({
    required this.content,
    required this.lineColor,
    required this.thickness,
    required this.spacing,
    required this.lineWidth,
  });

  static Widget text({
    required String label,
    Color? color,
    Color? lineColor,
    double lineWidth = 60.0,
    double spacing = 16.0,
    double thickness = 1.0,
    TextStyle? textStyle,
    double height = 40.0,
  }) {
    final textColor = color ?? textStyle?.color ?? Colors.white;
    final effectiveLineColor = lineColor ?? textColor.withColorOpacity(0.5);

    return CustomPaint(
      size: Size(double.infinity, height.h),
      painter: CenterTextDivider(
        content: TextSpan(
          text: label,
          style: textStyle ??
              TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: textColor),
        ),
        lineColor: effectiveLineColor,
        thickness: thickness,
        spacing: spacing.w,
        lineWidth: lineWidth.w,
      ),
    );
  }

  static Widget icon({
    required Widget child,
    Color? lineColor,
    double lineWidth = 60.0,
    double spacing = 16.0,
    double thickness = 1.0,
    double height = 40.0,
  }) {
    return CustomPaint(
      size: Size(double.infinity, height.h),
      painter: CenterTextDivider(
        content: WidgetSpan(alignment: PlaceholderAlignment.middle, child: child),
        lineColor: lineColor ?? Colors.white.withColorOpacity(0.5),
        thickness: thickness,
        spacing: spacing.w,
        lineWidth: lineWidth.w,
      ),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;

    final textPainter = TextPainter(text: content, textDirection: TextDirection.ltr)..layout();

    final contentWidth = textPainter.width;
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final leftLineEnd = centerX - (contentWidth / 2) - spacing;
    final leftLineStart = leftLineEnd - lineWidth;
    final rightLineStart = centerX + (contentWidth / 2) + spacing;
    final rightLineEnd = rightLineStart + lineWidth;

    if (lineWidth > 0) {
      canvas.drawLine(Offset(leftLineStart, centerY), Offset(leftLineEnd, centerY), paint);
      canvas.drawLine(Offset(rightLineStart, centerY), Offset(rightLineEnd, centerY), paint);
    }

    textPainter.paint(canvas, Offset(centerX - (contentWidth / 2), centerY - (textPainter.height / 2)));
  }

  @override
  bool shouldRepaint(covariant CenterTextDivider oldDelegate) => false;
}
