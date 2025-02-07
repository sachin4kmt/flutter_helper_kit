import 'dart:math' as math;
import 'package:flutter_helper_kit/flutter_helper_kit.dart';
import 'package:flutter/material.dart';

/// Num Extensions
extension NumExt on num? {
  /// Checks if the given String [s] is null or empty
  bool isNull() => this == null;

  /// Validate given double is not null and returns given value if null.
  num validate({num value = 0}) => this ?? value;

  /// Returns Size
  Size squareSize() => Size(validate().toDouble(), validate().toDouble());

  /// Returns a square [Size] object with the current value as both width and height.
  ///
  /// Example:
  /// ```dart
  /// Size squareSize = 50.0.squareSizeBox;
  /// print('Square Size: $squareSize'); // Output: Size(50.0, 50.0)
  /// ```
  SizedBox squareSizeBox() =>
      SizedBox(width: validate().toDouble(), height: validate().toDouble());

  /// Leaves given height of space
  Widget height() => SizedBox(height: validate().toDouble());

  /// Leaves given width of space
  Widget width() => SizedBox(width: validate().toDouble());

  /// This extension provides a method to convert a nullable int value to a Widget that
  /// takes a fixed amount of space in the direction of its parent.
  Widget space() => Space(validate().toDouble());

  /// A widget that takes, at most, an amount of space in a [Row], [Column],or [Flex] widget.
  /// The `maxSpace` property converts the integer value to a [MaxSpace] widget,
  /// which is useful for creating flexible layouts where certain elements
  /// need to occupy a specific amount of space.
  Widget maxSpace() => MaxSpace(validate().toDouble());

  /// This extension provides a way to handle nullable integers and use them to create
  /// a space widget. It validates the nullable integer, converting it to a non-nullable
  /// double, and uses it to create a space widget that expands in the cross axis direction.
  Widget spaceExpand() => Space.expand(validate().toDouble());

  /// Adds a zero prefix to the given integer if it is less than 10.
  ///
  /// Returns a string representation of the integer with a leading '0' if
  /// the integer is a single-digit number (less than 10).
  /// If the integer is `null`, it returns `null`.
  ///
  /// Example:
  /// ```dart
  /// int? value = 5;
  /// print(value.addZeroPrefix()); // Output: '05'
  /// ```
  /// ```dart
  /// int? value = 15;
  /// print(value.addZeroPrefix()); // Output: '15'
  /// ```
  /// ```dart
  /// int? value = null;
  /// print(value.addZeroPrefix()); // Output: null
  /// ```
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

  /// Increases the number by the given percentage.
  ///
  /// If the number is `null`, returns `null`.
  /// Otherwise, it returns the number increased by the specified percentage.
  ///
  /// Example:
  /// ```dart
  /// num value = 100;
  /// print(value.increaseByPercentage(20)); // Output: 120.0 (20% increase)
  /// ```
  num? increaseByPercentage(double percentage) {
    if (isNull()) return null;
    return (this ?? 0) + ((this ?? 0) * (percentage / 100));
  }

  /// Decreases the number by the given percentage.
  ///
  /// If the number is `null`, returns `null`.
  /// Otherwise, it returns the number decreased by the specified percentage.
  ///
  /// Example:
  /// ```dart
  /// num value = 100;
  /// print(value.decreaseByPercentage(20)); // Output: 80.0 (20% decrease)
  /// ```
  num? decreaseByPercentage(double percentage) {
    if (isNull()) return null;
    return (this ?? 0) - ((this ?? 0) * (percentage / 100));
  }

  /// Calculates the absolute percentage difference between the current number
  /// and another number.
  ///
  /// If the current number or the other number is `null`, returns `null`.
  /// Otherwise, returns the absolute percentage difference.
  ///
  /// Example:
  /// ```dart
  /// num value1 = 100;
  /// num value2 = 120;
  /// print(value1.percentageDifference(value2)); // Output: 20.0 (percentage difference between 100 and 120)
  /// ```
  num? percentageDifference(double other) {
    if (isNull()) return null;
    return (((this ?? 0) - other).abs() / (this ?? 0)) * 100;
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

  /// Generates lorem ipsum text with the given number of words.
  ///
  /// Example:
  /// ```dart
  /// print(10.generateLoremIpsumWords()); // Output: "Lorem ipsum dolor sit amet consectetur adipiscing elit"
  /// ```
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

  /// Generates a list of random numbers with a given length.
  ///
  /// Example:
  /// ```dart
  /// print(5.randomList(min: 10, max: 50));
  /// ```
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
    if (isNull()) {
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

  /// Converts the number to a numeral format (e.g., 1K, 1M, etc.).
  ///
  /// Example:
  /// ```dart
  /// print(1000.toNumeral()); // Output: "1K"
  /// ```
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
