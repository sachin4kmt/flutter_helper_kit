import 'package:flutter/material.dart';

import '../flutter_tag_position.dart';

class FlutterCalculationUtils {
  /// Recalculates the position of the badge, ensuring all values are non-negative.
  /// If no position is provided, it defaults to top-right corner with end: 0, top: 0.
  static FlutterTagPosition calculatePosition(FlutterTagPosition? position) {
    if (position == null) {
      return FlutterTagPosition.custom(end: 0, top: 0);
    }

    double? getUpdatedPosition(double? digit) {
      if (digit == null) {
        return null;
      }
      return !digit.isNegative ? digit : 0;
    }

    return FlutterTagPosition.custom(
      start: getUpdatedPosition(position.start),
      end: getUpdatedPosition(position.end),
      top: getUpdatedPosition(position.top),
      bottom: getUpdatedPosition(position.bottom),
    );
  }

  /// Calculates the padding for a tappable badge based on its position.
  /// Defaults to EdgeInsets.only(top: 8, right: 10) if no position is provided.
  static EdgeInsets calculatePadding(FlutterTagPosition? position) {
    if (position == null) {
      return const EdgeInsets.only(top: 8, right: 10);
    }

    if (position.isCenter) {
      return EdgeInsets.zero;
    }

    double getUpdatedPadding(double? digit) {
      if (digit == null || !digit.isNegative) {
        return 0;
      }
      return digit.abs();
    }

    if (position.top != null && position.start != null) {
      return EdgeInsets.only(
          top: getUpdatedPadding(position.top),
          left: getUpdatedPadding(position.start));
    }
    return EdgeInsets.only(
      top: getUpdatedPadding(position.top),
      bottom: getUpdatedPadding(position.bottom),
      left: getUpdatedPadding(position.start),
      right: getUpdatedPadding(position.end),
    );
  }

  /// Calculates the offset for a given alignment within a specified width and height.
  static Offset calculateOffset({
    required AlignmentGeometry alignment,
    required double width,
    required double height,
  }) {
    return switch (alignment) {
      (Alignment.topLeft) => Offset(width * 0.191, height * 0.191),
      (Alignment.center) => Offset(width * 0.5, height * 0.5),
      (Alignment.bottomRight) => Offset(width * 0.809, height * 0.809),
      (Alignment.centerLeft) => Offset(width * 0.06, height * 0.5),
      (Alignment.bottomCenter) => Offset(width * 0.5, height * 0.94),
      (Alignment.bottomLeft) => Offset(width * 0.191, height * 0.809),
      (Alignment.centerRight) => Offset(width * 0.94, height * 0.5),
      (Alignment.topCenter) => Offset(width * 0.5, height * 0.06),
      (Alignment.topRight) => Offset(width * 0.809, height * 0.191),
      (_) => Offset(width, height),
    };
  }

  /// Calculates the center offset for a given size.
  static Offset calculateCenterOffset(
      {required double width, required double height}) {
    return Offset(width / 2, height / 2);
  }

  /// Calculates the scaled position for a widget based on its size and the desired scale factor.
  static Offset calculateScaledPosition({
    required Offset position,
    required double scaleFactor,
  }) {
    return Offset(position.dx * scaleFactor, position.dy * scaleFactor);
  }

  /// Calculates the boundary box for a widget given its position, size, and padding.
  static Rect calculateBoundaryBox({
    required Offset position,
    required Size size,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return Rect.fromLTRB(
      position.dx - padding.left,
      position.dy - padding.top,
      position.dx + size.width + padding.right,
      position.dy + size.height + padding.bottom,
    );
  }
}
