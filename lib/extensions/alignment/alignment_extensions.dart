
import 'package:flutter/material.dart';

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
/// Extension on [Alignment] to provide easy checks
/// for vertical and horizontal positioning.
extension AlignmentExtensions on Alignment {
  /// Returns `true` if the alignment is vertically aligned toward the top.
  /// For example: [Alignment.topCenter], [Alignment.topLeft], [Alignment.topRight]
  bool get isTop => y < 0;

  /// Returns `true` if the alignment is vertically aligned toward the bottom.
  /// For example: [Alignment.bottomCenter], [Alignment.bottomLeft], [Alignment.bottomRight]
  bool get isBottom => y > 0;

  /// Returns `true` if the alignment is vertically centered.
  /// For example: [Alignment.center], [Alignment.centerLeft], [Alignment.centerRight]
  bool get isCenterVertical => y == 0;

  /// Returns `true` if the alignment is horizontally aligned toward the left.
  /// For example: [Alignment.topLeft], [Alignment.centerLeft], [Alignment.bottomLeft]
  bool get isLeft => x < 0;

  /// Returns `true` if the alignment is horizontally aligned toward the right.
  /// For example: [Alignment.topRight], [Alignment.centerRight], [Alignment.bottomRight]
  bool get isRight => x > 0;

  /// Returns `true` if the alignment is horizontally centered.
  /// For example: [Alignment.center], [Alignment.topCenter], [Alignment.bottomCenter]
  bool get isCenterHorizontal => x == 0;
}
