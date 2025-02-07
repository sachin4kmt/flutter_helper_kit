import 'package:flutter/material.dart';

/// Padding utilities.
extension PaddingExtension on num {
  /// Padding for all sides.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   padding: 16.padAll, // Adds padding of 16px from all sides.
  ///   child: Text("Hello Flutter"),
  /// ),
  /// ```
  EdgeInsets get padAll => EdgeInsets.all(toDouble());

  /// Horizontal padding.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   padding: 16.padX, // Adds horizontal padding of 16px.
  ///   child: Text("Hello Flutter"),
  /// ),
  /// ```
  EdgeInsets get padHorizontal => EdgeInsets.symmetric(horizontal: toDouble());

  /// Vertical padding.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   padding: 16.padX, // Adds vertical padding of 16px.
  ///   child: Text("Hello Flutter"),
  /// ),
  /// ```
  EdgeInsets get padVertical => EdgeInsets.symmetric(vertical: toDouble());

  /// Padding on the left.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   padding: 16.padLeft, // Adds padding of 16px from Left.
  ///   child: Text("Hello Flutter"),
  /// ),
  /// ```
  EdgeInsets get padLeft => EdgeInsets.only(left: toDouble());

  /// Padding on the right.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   padding: 16.padRight, // Adds padding of 16px from Right.
  ///   child: Text("Hello Flutter"),
  /// ),
  /// ```
  EdgeInsets get padRight => EdgeInsets.only(right: toDouble());

  /// Padding on the top.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   padding: 16.padTop, // Adds padding of 16px from Top.
  ///   child: Text("Hello Flutter"),
  /// ),
  /// ```
  EdgeInsets get padTop => EdgeInsets.only(top: toDouble());

  /// Padding on the bottom.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   padding: 16.padBottom, // Adds padding of 16px from Bottom.
  ///   child: Text("Hello Flutter"),
  /// ),
  /// ```
  EdgeInsets get padBottom => EdgeInsets.only(bottom: toDouble());
}

extension PaddingWidgetExtension on Widget {
  /// return padding top
  Padding paddingTop(double top) {
    return Padding(padding: EdgeInsets.only(top: top), child: this);
  }

  /// return padding left
  Padding paddingLeft(double left) {
    return Padding(padding: EdgeInsets.only(left: left), child: this);
  }

  /// return padding right
  Padding paddingRight(double right) {
    return Padding(padding: EdgeInsets.only(right: right), child: this);
  }

  /// return padding bottom
  Padding paddingBottom(double bottom) {
    return Padding(padding: EdgeInsets.only(bottom: bottom), child: this);
  }

  /// return padding all
  Padding paddingAll(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }

  /// return custom padding from each side
  Padding paddingOnly({
    double top = 0.0,
    double left = 0.0,
    double bottom = 0.0,
    double right = 0.0,
  }) {
    return Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom), child: this);
  }

  /// return padding symmetric
  Padding paddingSymmetric({double vertical = 0.0, double horizontal = 0.0}) {
    return Padding(
        padding:
            EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
        child: this);
  }
}
