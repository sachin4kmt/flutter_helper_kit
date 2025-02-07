import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/extensions/list/list_extension.dart';

extension ListWidgetExtension on List<Widget> {
  /// Wraps each widget inside an `Expanded` widget.
  ///
  /// This method ensures that all widgets share available space equally
  /// when placed inside a `Row` or `Column`.
  ///
  /// Example:
  /// ```dart
  /// Row(children: [Text("A"), Text("B"), Text("C")].expandEvery())
  /// ```
  List<Widget> expandEvery() => map((Widget e) => Expanded(child: e)).toList();

  /// Wraps each widget inside a `Flexible` widget.
  ///
  /// This allows each widget to take up flexible space but does not
  /// force them to occupy equal amounts.
  ///
  /// Example:
  /// ```dart
  /// Row(children: [Text("X"), Text("Y"), Text("Z")].flexibleEvery())
  /// ```
  List<Widget> flexibleEvery() =>
      map((Widget e) => Flexible(child: e)).toList();

  /// Inserts a `Spacer` widget between each widget in the list.
  ///
  /// This helps to evenly distribute widgets inside a `Row` or `Column`
  /// with spacing between them.
  ///
  /// Example:
  /// ```dart
  /// Row(children: [Text("1"), Text("2"), Text("3")].spacerEvery())
  /// ```
  List<Widget> spacerEvery() {
    List<Widget> list = <Widget>[];
    forEachIndexed((index, element) {
      index == (length - 1)
          ? list.add(this[index])
          : list.addAll([this[index], const Spacer()]);
    });
    return list;
  }
}
