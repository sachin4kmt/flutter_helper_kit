import 'package:flutter/material.dart';

import 'alignment_extensions.dart';
import 'core/alignment_axis.dart';

/// [AlignmentGeometry] helpers that resolve against [TextDirection].
extension AlignmentGeometryExtensions on AlignmentGeometry {
  /// Resolves this geometry to a concrete [Alignment].
  Alignment resolveAlignment(TextDirection textDirection) =>
      resolve(textDirection);

  /// Returns `true` when the resolved alignment is toward the top.
  bool isTopResolved(TextDirection textDirection) =>
      resolveAlignment(textDirection).isTop;

  /// Returns `true` when the resolved alignment is toward the bottom.
  bool isBottomResolved(TextDirection textDirection) =>
      resolveAlignment(textDirection).isBottom;

  /// Returns `true` when the resolved alignment is vertically centered.
  bool isCenterVerticalResolved(TextDirection textDirection) =>
      resolveAlignment(textDirection).isCenterVertical;

  /// Returns `true` when the resolved alignment is toward the left.
  bool isLeftResolved(TextDirection textDirection) =>
      resolveAlignment(textDirection).isLeft;

  /// Returns `true` when the resolved alignment is toward the right.
  bool isRightResolved(TextDirection textDirection) =>
      resolveAlignment(textDirection).isRight;

  /// Returns `true` when the resolved alignment is horizontally centered.
  bool isCenterHorizontalResolved(TextDirection textDirection) =>
      resolveAlignment(textDirection).isCenterHorizontal;

  /// Returns `true` when the resolved alignment is centered on both axes.
  bool isCenterResolved(TextDirection textDirection) =>
      resolveAlignment(textDirection).isCenter;

  /// Vertical bucket after resolving for [textDirection].
  AlignmentVertical verticalAxisResolved(TextDirection textDirection) =>
      resolveAlignment(textDirection).verticalAxis;

  /// Horizontal bucket after resolving for [textDirection].
  AlignmentHorizontal horizontalAxisResolved(TextDirection textDirection) =>
      resolveAlignment(textDirection).horizontalAxis;
}
