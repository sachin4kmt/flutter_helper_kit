import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/extensions/list_extension.dart';

extension ListWidgetExtension on List<Widget> {
  List<Widget> get expandEvery =>
      map((Widget e) => Expanded(child: e)).toList();

  List<Widget> get flexibleEvery =>
      map((Widget e) => Flexible(child: e)).toList();

  List<Widget> get spacerEvery {
    List<Widget> list = <Widget>[];
    forEachIndexed((index, element) {
      index == (length - 1)
          ? list.add(this[index])
          : list.addAll([this[index], const Spacer()]);
    });
    return list;
  }
}

extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandEqually() =>
      map((widget) => Expanded(flex: 1, child: widget));
}
