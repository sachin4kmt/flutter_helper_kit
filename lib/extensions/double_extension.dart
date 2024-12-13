import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Double Extensions
extension DoubleOrNullExtensions on double? {
  /// Validates the double value and returns it if not null.
  ///
  /// If the value is null, returns 0.0.
  double validate({double value = 0.0}) => this ?? value;

  /// Returns a [BorderRadius] with circular radius.
  ///
  /// Example:
  /// ```dart
  /// double radius = 5.0;
  /// BorderRadius borderRadius = radius.circularRadius;
  /// ```
  BorderRadius circularRadius() => validate().circularRadius();

  /// Checks if the current value falls between the specified range.
  ///
  /// Returns `true` if the current value is between [first] and [second],
  /// otherwise returns `false`.
  ///
  /// Example:
  /// ```dart
  /// bool isInRange = 100.0.isBetween(50.0, 150.0);
  /// print('Is in range? $isInRange'); // Output: true
  /// ```
  bool isBetween(num first, num second) {
    return validate().isBetween(first, second);
  }

  /// Returns a square [Size] object with the current value as both width and height.
  ///
  /// Example:
  /// ```dart
  /// Size squareSize = 50.0.squareSizeBox;
  /// print('Square Size: $squareSize'); // Output: Size(50.0, 50.0)
  /// ```
  SizedBox squareSizeBox() => validate().squareSizeBox();

  /// Returns a square [Size] with the current value as both width and height.
  ///
  /// Example:
  /// ```dart
  /// double sideLength = 100.0;
  /// Size squareSize = sideLength.squareSize; // Output: Size(100.0, 100.0)
  /// ```
  Size squareSize() => validate().squareSize();
}
extension DoubleExtensions on double {
  /// Returns a [BorderRadius] with circular radius.
  ///
  /// Example:
  /// ```dart
  /// double radius = 5.0;
  /// BorderRadius borderRadius = radius.circularRadius;
  /// ```
  BorderRadius circularRadius() => BorderRadius.circular(validate());

  /// Checks if the current value falls between the specified range.
  ///
  /// Returns `true` if the current value is between [first] and [second],
  /// otherwise returns `false`.
  ///
  /// Example:
  /// ```dart
  /// bool isInRange = 100.0.isBetween(50.0, 150.0);
  /// print('Is in range? $isInRange'); // Output: true
  /// ```
  bool isBetween(num first, num second) {
    final lower = math.min(first, second);
    final upper = math.max(first, second);
    return validate() >= lower && validate() <= upper;
  }

  /// Returns a square [Size] object with the current value as both width and height.
  ///
  /// Example:
  /// ```dart
  /// Size squareSize = 50.0.squareSizeBox;
  /// print('Square Size: $squareSize'); // Output: Size(50.0, 50.0)
  /// ```
  SizedBox squareSizeBox() => SizedBox(width: this, height: this);

  /// Returns a square [Size] with the current value as both width and height.
  ///
  /// Example:
  /// ```dart
  /// double sideLength = 100.0;
  /// Size squareSize = sideLength.squareSize; // Output: Size(100.0, 100.0)
  /// ```
  Size squareSize() => Size(this, this);
}
