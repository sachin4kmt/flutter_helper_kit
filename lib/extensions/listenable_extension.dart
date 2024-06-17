
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension ListenableExtension on Listenable {
  Widget builder({required TransitionBuilder builder, Widget? child}) {
    return AnimatedBuilder(
      animation: this,
      builder: builder,
      child: child,
    );
  }
}

extension ValueListenableExtension<T> on ValueListenable<T> {
  ///ValueListenable listener widget that only expose value
  Widget listen(Widget Function(T value) builder) {
    return AnimatedBuilder(
      animation: this,
      builder: (context, child) {
        return builder(value);
      },
    );
  }

  ///ValueListenable listener widget that support [child]
  Widget listenChild({
    required Widget Function(T, Widget?) builder,
    Widget? child,
  }) {
    return AnimatedBuilder(
      animation: this,
      child: child,
      builder: (context, child) {
        return builder(value, child);
      },
    );
  }
}

extension BoolValueListenableExtension<bool> on ValueListenable<bool> {
  ///ValueListenable listener widget that only build if value is true
  Widget buildWhenTrue(Widget Function() builder, {Widget? onFalse}) {
    return ValueListenableBuilder<bool>(
      valueListenable: this,
      builder: (context, value, child) {
        if (value == true) return builder();
        return onFalse ??  const SizedBox.shrink();
      },
    );
  }
}
