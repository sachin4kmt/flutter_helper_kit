import 'dart:math' as math;
import 'package:flutter_helper_kit/flutter_helper_kit.dart';
import 'package:flutter/material.dart';

/// Num Extensions
extension NumExt on num? {
  /// Checks if the given String [s] is null or empty
  bool isNull() => this == null;

  /// Validate given double is not null and returns given value if null.
  num validate({num value = 0}) => this ?? value;

  /// Returns a [BorderRadius] with circular radius.
  ///
  /// Example:
  /// ```dart
  /// double radius = 5.0;
  /// BorderRadius borderRadius = radius.circularRadius;
  /// ```
  BorderRadius circularRadius() => BorderRadius.circular(validate().toDouble());

  /// Returns Size
  Size squareSize() =>
      Size(this.validate().toDouble(), this.validate().toDouble());

  /// Returns a square [Size] object with the current value as both width and height.
  ///
  /// Example:
  /// ```dart
  /// Size squareSize = 50.0.squareSizeBox;
  /// print('Square Size: $squareSize'); // Output: Size(50.0, 50.0)
  /// ```
  SizedBox squareSizeBox() => SizedBox(
      width: this.validate().toDouble(), height: this.validate().toDouble());

  /// Leaves given height of space
  Widget height() => SizedBox(height: this.validate().toDouble());

  /// Leaves given width of space
  Widget width() => SizedBox(width: this.validate().toDouble());

  /// This extension provides a method to convert a nullable int value to a Widget that
  /// takes a fixed amount of space in the direction of its parent.
  Widget space() => Space(this.validate().toDouble());

  /// A widget that takes, at most, an amount of space in a [Row], [Column],or [Flex] widget.
  /// The `maxSpace` property converts the integer value to a [MaxSpace] widget,
  /// which is useful for creating flexible layouts where certain elements
  /// need to occupy a specific amount of space.
  Widget maxSpace() => MaxSpace(this.validate().toDouble());

  /// This extension provides a way to handle nullable integers and use them to create
  /// a space widget. It validates the nullable integer, converting it to a non-nullable
  /// double, and uses it to create a space widget that expands in the cross axis direction.
  Widget spaceExpand() => Space.expand(this.validate().toDouble());

  /// Validate given int is not null and returns given value if null.
  String? addZeroPrefix() {
    if (isNull()) {
      return null;
    }
    if ((this!) < 10) {
      return '0$this';
    } else {
      return toString();
    }
  }

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

  /// Check if the number is in the range [min] to [max].
  /// Returns `true` if the number is in the range, `false` otherwise.
  bool isInRange(num min, num max) => (this ?? 0) >= min && (this ?? 0) <= max;

  /// Get the lorem ipsum text of [this] words.
  String generateLoremIpsumWords() {
    if (isNull()) return '';
    var words =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
            .split(' ');
    var result = '';
    for (var i = 0; i < (this ?? words.length); i++) {
      result += '${words[i % words.length]} ';
    }
    return result.trim();
  }

  /// Get list of random numbers.
  List<num> randomList({int min = 0, int max = 100}) {
    if (isNull()) return [];
    var result = <num>[];
    for (var i = 0; i < (this ?? 0); i++) {
      result.add(math.Random().nextInt(max - min) + min);
    }
    return result;
  }

  /// Formats the number by adding a prefix or suffix based on its value
  /// compared to a threshold, with optional formatting for decimals.
  String formatWithMax({
    required num max,
    String? prefix,
    String? suffix,
    int decimalPlaces = 0,
    String Function(num value)? customFormat,
  }) {
    if (this.isNull()) {
      return '';
    }
    // Apply a custom format if provided
    if (customFormat != null) {
      return customFormat(this ?? 0);
    }

    // Round the number to the specified decimal places
    final roundedValue = decimalPlaces > 0
        ? (this ?? 0.0).toStringAsFixed(decimalPlaces)
        : toString();

    // Add prefix and suffix if the number exceeds the threshold
    if ((this ?? 0) > max) {
      return '${prefix ?? ''}$roundedValue${suffix ?? ''}';
    }

    return roundedValue; // Return the formatted number as a string
  }

  /// Num value convert into numeral String Like 1K, 10K, 1M, 10M
  /// [international] is default [true] for international value =>  1k,2k,1m,2m
  /// [international] [false] for indian value => 1k,2k,1 L,2 L, 1 Cr
  String toNumeral({bool international = true, int digitAfterDecimal = 0}) {
    final value = Numeral(validate(), digitAfterDecimal: digitAfterDecimal);
    return international ? value.international : value.indian;
  }

  SharpBorderRadius get circularSharpBorderRadius => SharpBorderRadius.all(
      SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1));
  SharpBorderRadius get topLeftSharpBorderRadius => SharpBorderRadius.only(
      topLeft:
          SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1));
  SharpBorderRadius get topRightSharpBorderRadius => SharpBorderRadius.only(
      topRight:
          SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1));
  SharpBorderRadius get bottomLeftSharpBorderRadius => SharpBorderRadius.only(
      bottomLeft:
          SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1));
  SharpBorderRadius get bottomRightSharpRadius => SharpBorderRadius.only(
      bottomRight:
          SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1));
  SharpRadius get sharpRadius =>
      SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1);
}
