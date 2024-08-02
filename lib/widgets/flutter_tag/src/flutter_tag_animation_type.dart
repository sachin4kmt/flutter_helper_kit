import 'flutter_tag_widget.dart' as badges;
import 'package:flutter/material.dart';

/// This is a set of animations that you can use for your [badges.Tag] widget.
/// Do not use them explicitly, use for example [TagAnimation.slide()] instead.
enum FlutterTagAnimationType {
  /// See also:
  /// * [SlideTransition]
  slide,

  /// See also:
  /// * [ScaleTransition]
  scale,

  /// See also:
  /// * [FadeTransition]
  fade,

  /// See also:
  /// * [SizeTransition]
  size,

  /// See also:
  /// * [RotationTransition]
  rotation,

  /// See also:
  /// * [RotationTransition]
  flip
}
