import 'package:flutter/material.dart';

import 'scale_calculator.dart';

/// Provides [ScaleCalculator] to the widget tree without relying on globals.
class ResponsiveScope extends InheritedWidget {
  const ResponsiveScope({
    super.key,
    required this.calculator,
    required super.child,
  });

  final ScaleCalculator calculator;

  static ScaleCalculator? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ResponsiveScope>()
        ?.calculator;
  }

  static ScaleCalculator of(BuildContext context) {
    final calculator = maybeOf(context);
    assert(
      calculator != null,
      'ResponsiveScope not found. Wrap your app with ScreenUtilInit.',
    );
    return calculator!;
  }

  @override
  bool updateShouldNotify(ResponsiveScope oldWidget) =>
      calculator != oldWidget.calculator;
}
