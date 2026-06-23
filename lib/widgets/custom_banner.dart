
import 'dart:math' as math;

import 'package:flutter/material.dart';

const double _kBannerDefaultOffset = 40.0;
const double _kBannerDefaultHeight = 12.0;
const Color _kBannerDefaultColor = Color(0xA0B71C1C);
const BoxShadow _kBannerDefaultShadow = BoxShadow(color: Color(0x7F000000), blurRadius: 6.0);

/// Where to show a [Banner].
///
/// The start and end locations are relative to the ambient [Directionality]
/// (which can be overridden by [Banner.layoutDirection]).
enum CustomBannerLocation {
  /// Show the banner in the top-right corner when the ambient [Directionality]
  /// (or [Banner.layoutDirection]) is [TextDirection.rtl] and in the top-left
  /// corner when the ambient [Directionality] is [TextDirection.ltr].
  topStart,

  /// Show the banner in the top-left corner when the ambient [Directionality]
  /// (or [Banner.layoutDirection]) is [TextDirection.rtl] and in the top-right
  /// corner when the ambient [Directionality] is [TextDirection.ltr].
  topEnd,

  /// Show the banner in the bottom-right corner when the ambient
  /// [Directionality] (or [Banner.layoutDirection]) is [TextDirection.rtl] and
  /// in the bottom-left corner when the ambient [Directionality] is
  /// [TextDirection.ltr].
  bottomStart,

  /// Show the banner in the bottom-left corner when the ambient
  /// [Directionality] (or [Banner.layoutDirection]) is [TextDirection.rtl] and
  /// in the bottom-right corner when the ambient [Directionality] is
  /// [TextDirection.ltr].
  bottomEnd,
}

class _CustomBannerPainter extends CustomPainter {
  _CustomBannerPainter({
    required this.message,
    required this.textDirection,
    required this.location,
    required this.layoutDirection,
    required this.color,
    required this.textStyle,
    required this.shadow,
    required this.offset,
    required this.height,
  }) : super(repaint: PaintingBinding.instance.systemFonts);

  final String message;
  final TextDirection textDirection;
  final CustomBannerLocation location;
  final TextDirection layoutDirection;
  final Color color;
  final TextStyle textStyle;
  final BoxShadow shadow;
  final double offset;
  final double height;

  // Diagonal movement calculation
  double get _totalBottomOffset => offset + (math.sqrt1_2 * height);

  // Banner drawing area
  Rect get _bannerRect => Rect.fromLTWH(-offset, offset - height, offset * 2.0, height);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintBanner = Paint()..color = color;
    final Paint paintShadow = shadow.toPaint();

    final TextPainter textPainter = TextPainter(
      text: TextSpan(style: textStyle, text: message),
      textAlign: TextAlign.center,
      textDirection: textDirection,
    )..layout(minWidth: offset * 2.0, maxWidth: offset * 2.0);

    canvas.save();

    // Position the canvas
    canvas.translate(_translationX(size.width), _translationY(size.height));
    canvas.rotate(_rotation);

    // Draw Banner Background
    canvas.drawRect(_bannerRect, paintShadow);
    canvas.drawRect(_bannerRect, paintBanner);

    // Draw Text (Logically centered within height)
    final double textTop = _bannerRect.top + (_bannerRect.height - textPainter.height) / 2.0;
    textPainter.paint(canvas, Offset(_bannerRect.left, textTop));

    canvas.restore();
  }

  double _translationX(double width) {
    return switch ((layoutDirection, location)) {
      (TextDirection.rtl, CustomBannerLocation.topStart) => width,
      (TextDirection.ltr, CustomBannerLocation.topStart) => 0.0,
      (TextDirection.rtl, CustomBannerLocation.topEnd) => 0.0,
      (TextDirection.ltr, CustomBannerLocation.topEnd) => width,
      (TextDirection.rtl, CustomBannerLocation.bottomStart) => width - _totalBottomOffset,
      (TextDirection.ltr, CustomBannerLocation.bottomStart) => _totalBottomOffset,
      (TextDirection.rtl, CustomBannerLocation.bottomEnd) => _totalBottomOffset,
      (TextDirection.ltr, CustomBannerLocation.bottomEnd) => width - _totalBottomOffset,
    };
  }

  double _translationY(double height) {
    return switch (location) {
      CustomBannerLocation.bottomStart || CustomBannerLocation.bottomEnd => height - _totalBottomOffset,
      CustomBannerLocation.topStart || CustomBannerLocation.topEnd => 0.0,
    };
  }

  double get _rotation {
    return (math.pi / 4.0) *
        switch ((layoutDirection, location)) {
          (TextDirection.rtl, CustomBannerLocation.topStart || CustomBannerLocation.bottomEnd) => 1,
          (TextDirection.ltr, CustomBannerLocation.topStart || CustomBannerLocation.bottomEnd) => -1,
          (TextDirection.rtl, CustomBannerLocation.bottomStart || CustomBannerLocation.topEnd) => -1,
          (TextDirection.ltr, CustomBannerLocation.bottomStart || CustomBannerLocation.topEnd) => 1,
        };
  }

  @override
  bool shouldRepaint(_CustomBannerPainter oldDelegate) =>
      message != oldDelegate.message || location != oldDelegate.location || offset != oldDelegate.offset || height != oldDelegate.height;
}

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    super.key,
    this.child,
    required this.message,
    required this.location,
    this.textDirection,
    this.layoutDirection,
    this.color = const Color(0xA0B71C1C),
    this.textStyle,
    this.shadow = _kBannerDefaultShadow,
    this.bannerOffset = _kBannerDefaultOffset,
    this.bannerHeight = _kBannerDefaultHeight,
  });

  final Widget? child;
  final String message;
  final CustomBannerLocation location;
  final TextDirection? textDirection;
  final TextDirection? layoutDirection;
  final Color color;
  final TextStyle? textStyle;
  final BoxShadow shadow;
  final double bannerOffset;
  final double bannerHeight;

  @override
  Widget build(BuildContext context) {
    // Layout and Text directions default handling
    final TextDirection effectiveTextDirection = textDirection ?? Directionality.of(context);
    final TextDirection effectiveLayoutDirection = layoutDirection ?? Directionality.of(context);

    // Default text style based on banner height
    final TextStyle effectiveTextStyle =
        textStyle ?? TextStyle(color: _kBannerDefaultColor, fontSize: bannerHeight * 0.85, fontWeight: FontWeight.w900, height: 1.0);

    return ClipRect(
      // Ensure banner doesn't draw outside the child boundaries
      child: CustomPaint(
        foregroundPainter: _CustomBannerPainter(
          message: message,
          textDirection: effectiveTextDirection,
          location: location,
          layoutDirection: effectiveLayoutDirection,
          color: color,
          textStyle: effectiveTextStyle,
          shadow: shadow,
          offset: bannerOffset,
          height: bannerHeight,
        ),
        child: child,
      ),
    );
  }
}
