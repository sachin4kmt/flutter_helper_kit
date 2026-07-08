import 'package:flutter/material.dart';

import 'alignment_extensions.dart';
import 'core/alignment_axis.dart';

/// Direction-aware checks for [AlignmentDirectional] using the `start` axis.
extension AlignmentDirectionalExtensions on AlignmentDirectional {
  /// Returns `true` if the alignment is vertically aligned toward the top.
  bool get isTop => verticalAxis == AlignmentVertical.top;

  /// Returns `true` if the alignment is vertically aligned toward the bottom.
  bool get isBottom => verticalAxis == AlignmentVertical.bottom;

  /// Returns `true` if the alignment is vertically centered.
  bool get isCenterVertical => verticalAxis == AlignmentVertical.center;

  /// Returns `true` when `start` points toward the layout start edge.
  bool get isStart => horizontalAxisDirectional == AlignmentHorizontal.left;

  /// Returns `true` when `start` points toward the layout end edge.
  bool get isEnd => horizontalAxisDirectional == AlignmentHorizontal.right;

  /// Returns `true` when `start` is centered horizontally.
  bool get isCenterHorizontal =>
      horizontalAxisDirectional == AlignmentHorizontal.center;

  /// Returns `true` when both axes are centered.
  bool get isCenter => isCenterHorizontal && isCenterVertical;

  /// Resolved vertical bucket for this alignment.
  AlignmentVertical get verticalAxis => verticalAxisOf(y);

  /// Horizontal bucket based on the directional `start` coordinate.
  AlignmentHorizontal get horizontalAxisDirectional =>
      horizontalAxisOfDirectional(start);

  /// Resolves to [Alignment] for [textDirection].
  Alignment resolveAlignment(TextDirection textDirection) =>
      resolve(textDirection);

  /// Returns `true` when resolved alignment is toward the physical left.
  bool isLeftResolved(TextDirection textDirection) =>
      resolveAlignment(textDirection).isLeft;

  /// Returns `true` when resolved alignment is toward the physical right.
  bool isRightResolved(TextDirection textDirection) =>
      resolveAlignment(textDirection).isRight;
}
