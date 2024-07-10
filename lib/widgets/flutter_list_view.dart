import 'package:flutter/material.dart';

/// A widget that displays a scrollable list of items with dynamic heights.
///
/// This widget is designed to provide a customizable list view with optional item separators,
/// allowing developers to build lists in both horizontal and vertical directions.
///
/// ## Usage
///
/// To create a `FlutterListView`, you need to provide:
/// - `items`: A list of items to be displayed.
/// - `itemBuilder`: A function that builds a widget for each item based on its context and item data.
///
/// Additionally, you can customize the list view with:
/// - `padding`: Padding applied to the entire list view.
/// - `separatorBuilder`: A function that builds separators between items.
/// - `controller`: An optional controller for the scroll view.
/// - `scrollDirection`: The direction in which the list view scrolls (`horizontal` or `vertical`).
/// - `physics`: Optional physics for the scroll view.

/// - [FlutterScrollDirection], an enum to define scroll direction for the list view.
enum FlutterScrollDirection { horizontal, vertical }

/// A widget that displays a list of items with dynamic heights in a scrollable view.
class FlutterListView<T> extends StatelessWidget {
  /// Padding for the entire list view.
  final EdgeInsets? padding;

  /// Padding for each individual item.
  // final EdgeInsets itemPadding;

  /// List of items to be displayed.
  final List<T> items;

  /// Builder function to create widgets for each item.
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// Optional builder function to create separators between items.
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  /// Optional controller for the scroll view.
  final ScrollController? controller;

  /// Scroll direction of the list view.
  final FlutterScrollDirection scrollDirection;

  /// Optional physics for the scroll view.
  final ScrollPhysics? physics;
/*
  /// Creates a [FlutterListView] widget.
  const FlutterListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.itemPadding = const EdgeInsets.only(right: 20.0),
    this.controller,
    this.scrollDirection = ScrollDirection.horizontal,
    this.physics,
  });*/
  const FlutterListView.builder({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.padding,
    // this.itemPadding = const EdgeInsets.only(right: 20.0),
    this.controller,
    this.scrollDirection = FlutterScrollDirection.horizontal,
    this.physics,
  }): separatorBuilder =null;

  const FlutterListView.separator({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.controller,
    this.scrollDirection = FlutterScrollDirection.horizontal,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return Container();

    final scrollAxis = scrollDirection == FlutterScrollDirection.horizontal
        ? Axis.horizontal
        : Axis.vertical;

    final itemWidgets = <Widget>[];

    for (int i = 0; i < items.length; i++) {
      itemWidgets.add(itemBuilder(context, items[i]));
      if (separatorBuilder != null && i < items.length - 1) {
        itemWidgets.add(separatorBuilder!(context, i));
      }
    }

    return SingleChildScrollView(
      controller: controller,
      padding: padding,
      physics: physics,
      scrollDirection: scrollAxis,
      child: scrollDirection == FlutterScrollDirection.horizontal
          ? Row(children: itemWidgets)
          : Column(children: itemWidgets),
    );
  }
}

