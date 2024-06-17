import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/extensions/list_extension.dart';


class WidgetHelper {
    /// Intersperses a divider widget between a list of widgets.
  ///
  /// Returns a new list of widgets where a divider widget is inserted
  /// between each pair of adjacent widgets in the input list.
  ///
  /// The [leading] parameter specifies whether to add a divider before
  /// the first widget in the list (default is `false`).
  ///
  /// The [trailing] parameter specifies whether to add a divider after
  /// the last widget in the list (default is `false`).
  static List<Widget> intersperse(
      List<Widget> widgets,
      Widget divider, {
        bool leading = false,
        bool trailing = false,
      }) {
    if (widgets.isNullOrEmpty) return [];
    return [
      if (leading) divider,
      ...widgets
          .take(widgets.length - 1)
          .map((child) => [child, divider])
          .expand((element) => element)
          .toList(),
      widgets.last,
      if (trailing) divider,
    ];
  }

 /// Maps a list of objects to a list of widgets using a mapping function.
  ///
  /// Returns a new list of widgets where each object in the input list
  /// is mapped to a list of widgets using the provided mapping function.
  ///
  /// Example usage:
  /// ```dart
  /// List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  /// List<Widget> mappedWidgets = WidgetHelper.widgetMap(
  ///   items,
  ///   (item) => [Text(item), SizedBox(height: 10)],
  /// );
  /// ```
  static List<Widget> widgetMap<T>(
      List<T> widgets,
      List<Widget> Function(T) mapFunc,
      ) {
    return [
      ...widgets
          .map(mapFunc)
          .expand((element) => element)
          .toList(),
    ];
  }
}