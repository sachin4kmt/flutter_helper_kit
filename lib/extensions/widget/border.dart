import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

/// Border radius utilities.
extension BorderExtension on num? {
  /// Circular border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.circularRadius, // Makes all corners (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get circularRadius =>
      BorderRadius.circular(validate().toDouble());

  /// Left border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.leftRadius, // Makes left corners (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get leftRadius =>
      BorderRadius.horizontal(left: Radius.circular(validate().toDouble()));

  /// Right border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.rightRadius, // Makes right corners (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get rightRadius =>
      BorderRadius.horizontal(right: Radius.circular(validate().toDouble()));

  /// Top border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.topRadius, // Makes top corners (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get topRadius =>
      BorderRadius.vertical(top: Radius.circular(validate().toDouble()));

  /// Bottom border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.bottomRadius, // Makes bottom corners (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get bottomRadius =>
      BorderRadius.vertical(bottom: Radius.circular(validate().toDouble()));

  /// Top-left corner border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.topLeftRadius, // Makes top-left corner (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get topLeftRadius =>
      BorderRadius.only(topLeft: Radius.circular(validate().toDouble()));

  /// Top-right corner border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.topRightRadius, // Makes top-right corner (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get topRightRadius =>
      BorderRadius.only(topRight: Radius.circular(validate().toDouble()));

  /// Bottom-left corner border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.bottomLeftRadius, // Makes bottom-left corner (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get bottomLeftRadius =>
      BorderRadius.only(bottomLeft: Radius.circular(validate().toDouble()));

  /// Bottom-left corner border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.bottomRightRadius, // Makes bottom-right corner (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get bottomRightRadius =>
      BorderRadius.only(bottomRight: Radius.circular(validate().toDouble()));
}

extension SharpBorderExtension on num? {
  /// Circular border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.circularSharpRadius, // Makes all corners (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get circularSharpRadius => SharpBorderRadius.all(
      SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1));

  /// Left border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.leftSharpRadius, // Makes left corners (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get leftSharpRadius => SharpBorderRadius.horizontal(
      left: SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1));

  /// Right border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.rightSharpRadius, // Makes right corners (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get rightSharpRadius => SharpBorderRadius.horizontal(
      right: SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1));

  /// Top border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.topSharpRadius, // Makes top corners (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get topSharpRadius => SharpBorderRadius.vertical(
      top: SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1));

  /// Bottom border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.bottomSharpRadius, // Makes bottom corners (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get bottomSharpRadius => SharpBorderRadius.vertical(
      bottom: SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1));

  /// Top-left corner border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.topLeftSharpRadius, // Makes top-left corner (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get topLeftSharpRadius => SharpBorderRadius.only(
      topLeft:
          SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1));

  /// Top-right corner border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.topRightSharpRadius, // Makes top-right corner (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get topRightSharpRadius => SharpBorderRadius.only(
      topRight:
          SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1));

  /// Bottom-left corner border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.bottomLeftSharpRadius, // Makes bottom-left corner (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get bottomLeftSharpRadius => SharpBorderRadius.only(
      bottomLeft:
          SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1));

  /// Bottom-left corner border radius.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   child: Text("Hello Flutter"),
  ///   decoration: BoxDecoration(
  ///     borderRadius: 8.bottomRightSharpRadius, // Makes bottom-right corner (8px) rounded.
  ///   ),
  /// ),
  /// ```
  BorderRadius get bottomRightSharpRadius => SharpBorderRadius.only(
      bottomRight:
          SharpRadius(cornerRadius: (this ?? 0).toDouble(), sharpRatio: 1));
}
