import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension ListenableExtension on Listenable {
  /// Provides an `AnimatedBuilder` widget that listens to the `Listenable`
  /// and rebuilds its widget tree when the animation value changes.
  ///
  /// - `builder`: The builder function that defines the widget to rebuild when the animation value changes.
  /// - `child`: Optional child widget that can be passed down to the builder. It will be passed down unchanged when the widget is rebuilt.
  ///
  /// Example usage:
  /// ```dart
  /// ChangeNotifierProvider(
  ///   create: (context) => MyModel(),
  ///   child: Builder(
  ///     builder: (context) {
  ///       final model = Provider.of<MyModel>(context);
  ///       return model.someListenable.builder(
  ///         builder: (context, child) {
  ///           return Container(
  ///             color: model.isActive ? Colors.green : Colors.red,
  ///           );
  ///         },
  ///       );
  ///     },
  ///   ),
  /// );
  /// ```
  Widget builder({required TransitionBuilder builder, Widget? child}) {
    return AnimatedBuilder(
      animation: this,
      builder: builder,
      child: child,
    );
  }
}

// Extension for adding custom listener functionality to `ValueListenable`.
extension ValueListenableExtension<T> on ValueListenable<T> {
  /// Creates a widget that listens to the `ValueListenable` and rebuilds when
  /// the value changes.
  ///
  /// The `builder` function is called with the current value of the `ValueListenable`.
  ///
  /// Example usage:
  /// ```dart
  /// ValueListenableProvider<int>(
  ///   create: (_) => myValueListenable,
  ///   child: Builder(
  ///     builder: (context) {
  ///       return myValueListenable.listen((value) {
  ///         return Text('Value: $value');
  ///       });
  ///     },
  ///   ),
  /// );
  /// ```
  Widget listen(Widget Function(T value) builder) {
    return AnimatedBuilder(
      animation: this, // Listens to the `ValueListenable` for value changes.
      builder: (context, child) {
        return builder(
            value); // Rebuilds with the current value of the Listenable.
      },
    );
  }

  /// Creates a widget that listens to the `ValueListenable` and rebuilds when
  /// the value changes. It also supports an optional child widget for optimization.
  ///
  /// The `builder` function receives both the current value and the child widget.
  ///
  /// Example usage:
  /// ```dart
  /// ValueListenableProvider<int>(
  ///   create: (_) => myValueListenable,
  ///   child: Builder(
  ///     builder: (context) {
  ///       return myValueListenable.listenChild(
  ///         builder: (value, child) {
  ///           return Row(
  ///             children: [
  ///               Text('Value: $value'),
  ///               if (child != null) child,
  ///             ],
  ///           );
  ///         },
  ///       );
  ///     },
  ///   ),
  /// );
  /// ```
  Widget listenChild({
    required Widget Function(T value, Widget? child) builder,
    Widget? child,
  }) {
    return AnimatedBuilder(
      animation: this, // Listens to the `ValueListenable` for value changes.
      child:
          child, // Optionally passes the child to optimize the widget rebuild.
      builder: (context, child) {
        return builder(value,
            child); // Rebuilds with the current value and optional child.
      },
    );
  }
}

// Extension for `ValueListenable<bool>` that conditionally builds a widget
// based on whether the value is `true`.
extension BoolValueListenableExtension on ValueListenable<bool> {
  /// A widget that only rebuilds when the value is `true`.
  ///
  /// The `builder` function is executed when the value is `true`.
  /// If the value is `false`, an optional `onFalse` widget is displayed,
  /// or a `SizedBox.shrink()` is used by default to take up no space.
  ///
  /// - `builder`: The function that builds the widget when the value is `true`.
  /// - `onFalse`: An optional widget to be displayed when the value is `false`.
  ///
  /// Example usage:
  /// ```dart
  /// ValueNotifier<bool> isActive = ValueNotifier<bool>(false);
  /// isActive.buildWhenTrue(
  ///   () => Text('Active'),
  ///   onFalse: Text('Inactive'),
  /// );
  /// ```
  Widget buildWhenTrue(
    Widget Function() builder, {
    Widget? onFalse,
  }) {
    return ValueListenableBuilder<bool>(
      valueListenable: this, // Listens to the bool value.
      builder: (context, value, child) {
        if (value == true) {
          return builder(); // Build widget when value is true.
        }
        return onFalse ??
            const SizedBox
                .shrink(); // Build widget when value is false, default is SizedBox.shrink().
      },
    );
  }
}
