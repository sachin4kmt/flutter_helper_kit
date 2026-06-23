import 'package:flutter/material.dart';

class ShadowRadius {
  ShadowRadius({
    this.topLeft = Radius.zero,
    this.topRight = Radius.zero,
    this.bottomLeft = Radius.zero,
    this.bottomRight = Radius.zero,
  });

  /// Creates a border radius with only the given non-zero values. The other corners will be right angles.
  const ShadowRadius.only({
    this.topLeft = Radius.zero,
    this.topRight = Radius.zero,
    this.bottomLeft = Radius.zero,
    this.bottomRight = Radius.zero,
  });

  /// Creates a horizontally symmetrical border radius where the left and right sides of the rectangle have the same radii.
  ShadowRadius.horizontal({
    Radius left = Radius.zero,
    Radius right = Radius.zero,
  }) : this.only(
    topLeft: left,
    topRight: right,
    bottomLeft: left,
    bottomRight: right,
  );

  /// Creates a vertically symmetric border radius where the top and bottom sides of the rectangle have the same radii.
  ShadowRadius.vertical({
    Radius top = Radius.zero,
    Radius bottom = Radius.zero,
  }): this.only(
    topLeft: top,
    topRight: top,
    bottomLeft: bottom,
    bottomRight: bottom,
  );

  /// Creates a border radius where all radii are [radius].
  ShadowRadius.all(Radius radius) : this.only(
    topLeft: radius,
    topRight: radius,
    bottomLeft: radius,
    bottomRight: radius,
  );

  /// Creates a border radius where all radii are [Radius.circular(radius)].
  ShadowRadius.circular(double radius) : this.all(
    Radius.circular(radius),
  );

  /// A border radius with all zero radii.
  static ShadowRadius get zero => ShadowRadius.all(Radius.zero);

  final Radius topLeft;
  final Radius topRight;
  final Radius bottomLeft;
  final Radius bottomRight;
}