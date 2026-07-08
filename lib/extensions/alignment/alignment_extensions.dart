import 'package:flutter/material.dart';

import 'core/alignment_axis.dart';

/// Flutter Alignment Reference (x, y)
///
///                -y = -1.0 (Top)
///                     ↑
///                     |
///    (-1,-1)  topLeft       topCenter   (0,-1)       topRight   (1,-1)
///              +---------------+---------------+
///              |               |               |
///              |               |               |
///    -x= (-1, 0)  centerLeft     center      (0, 0)     centerRight  (1, 0) = x
///              |               |               |
///              |               |               |
///              +---------------+---------------+
///    (-1, 1)  bottomLeft   bottomCenter (0, 1)   bottomRight  (1, 1)
///
///                     |
///                     ↓
///                y = 1.0 (Bottom)
///
///        x = -1.0 (Left)      x = 0.0 (Center)     x = 1.0 (Right)
///
/// Legend:
/// • x-axis:
///   -1.0 → left, 0.0 → center, 1.0 → right
/// • y-axis:
///   -1.0 → top,  0.0 → center, 1.0 → bottom
///
/// Extension on [Alignment] for axis checks, transforms, and composition.
extension AlignmentExtensions on Alignment {
  /// Returns `true` if the alignment is vertically aligned toward the top.
  bool get isTop => verticalAxis == AlignmentVertical.top;

  /// Returns `true` if the alignment is vertically aligned toward the bottom.
  bool get isBottom => verticalAxis == AlignmentVertical.bottom;

  /// Returns `true` if the alignment is vertically centered.
  bool get isCenterVertical => verticalAxis == AlignmentVertical.center;

  /// Returns `true` if the alignment is horizontally aligned toward the left.
  bool get isLeft => horizontalAxis == AlignmentHorizontal.left;

  /// Returns `true` if the alignment is horizontally aligned toward the right.
  bool get isRight => horizontalAxis == AlignmentHorizontal.right;

  /// Returns `true` if the alignment is horizontally centered.
  bool get isCenterHorizontal => horizontalAxis == AlignmentHorizontal.center;

  /// Returns `true` when both axes are centered.
  bool get isCenter => isCenterHorizontal && isCenterVertical;

  /// Returns `true` when neither axis is centered (corner alignment).
  bool get isCorner => !isCenterHorizontal && !isCenterVertical;

  /// Returns `true` when exactly one axis is centered (edge alignment).
  bool get isEdge => isCenterHorizontal != isCenterVertical;

  /// Resolved vertical bucket for this alignment.
  AlignmentVertical get verticalAxis => verticalAxisOf(y);

  /// Resolved horizontal bucket for this alignment.
  AlignmentHorizontal get horizontalAxis => horizontalAxisOf(x);

  /// Alignment mirrored on both axes.
  Alignment get opposite => Alignment(-x, -y);

  /// Alignment mirrored horizontally.
  Alignment get flipX => Alignment(-x, y);

  /// Alignment mirrored vertically.
  Alignment get flipY => Alignment(x, -y);

  /// Combines this alignment with [other], averaging each axis.
  ///
  /// Useful for interpolating between two anchor points without
  /// pulling in `Alignment.lerp` semantics.
  Alignment combineWith(Alignment other, {double weight = 0.5}) {
    final t = weight.clamp(0.0, 1.0);
    return Alignment(
      x + (other.x - x) * t,
      y + (other.y - y) * t,
    );
  }
}
