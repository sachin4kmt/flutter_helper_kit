import 'dart:math';

import 'package:flutter/material.dart';

class FlipTransition extends AnimatedWidget {
  /// Creates a flip transition.
  ///
  /// The [animation] argument must not be null.
  const FlipTransition({
    super.key,
    required Animation<double> animation,
    this.alignment = Alignment.center,
    this.axis = Axis.horizontal,
    this.child,
  }) : super(listenable: animation);

  /// The animation that controls the flip of the child.
  Animation<double> get animation => listenable as Animation<double>;

  /// The alignment of the origin of the coordinate system in which the flip
  /// takes place, relative to the size of the box.
  ///
  /// Defaults to [Alignment.center].
  final Alignment alignment;

  /// The axis to flip around.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis axis;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final double angle = animation.value * pi;
    final bool isUnder = (animation.value > 0.5);

    return Transform(
      transform: (axis == Axis.horizontal)
          ? (Matrix4.rotationY(angle))
          : (Matrix4.rotationX(angle)),
      alignment: alignment,
      child: isUnder
          ? Transform(
              transform: (axis == Axis.horizontal)
                  ? (Matrix4.rotationY(pi))
                  : (Matrix4.rotationX(pi)),
              alignment: alignment,
              child: child,
            )
          : child,
    );
  }
}
