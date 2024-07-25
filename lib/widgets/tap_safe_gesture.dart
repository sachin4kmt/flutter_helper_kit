import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

class TapSafeGesture extends StatefulWidget {
  const TapSafeGesture({
    super.key,
    required this.builder,
    this.waitBuilder,
    this.onTap,
    this.cooldown,
  });

  /// Pass this time to constructor if want to allow only one tap and
  /// then disable button forever
  static const Duration kNeverCooldown = Duration(days: 100000000);

  /// Function that builds the widget.
  /// `context` is the current BuildContext.
  /// `onTap` is the function to pass to your button or InkWell.
  final Widget Function(BuildContext context, FutureVoidCallback? onTap)
      builder;

  /// Function that builds a special widget during the wait state.
  /// `context` is the current BuildContext.
  /// `child` is the widget returned from the builder method with onTap equal to null.
  final Widget Function(BuildContext context, Widget child)? waitBuilder;

  /// Function to call on tap.
  final Future<void> Function()? onTap;

  /// Cooldown duration - delay after onTap is executed (successfully or not).
  final Duration? cooldown;

  @override
  State<TapSafeGesture> createState() => _TapSafeGestureState();
}

class _TapSafeGestureState extends State<TapSafeGesture> {
  final _TapSafeGestureHandler _tapSafeGestureHandler =
      _TapSafeGestureHandler();

  @override
  void dispose() {
    _tapSafeGestureHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<bool>(
        initialData: false,
        stream: _tapSafeGestureHandler.busyStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasError) {
            throw StateError(
              '_TapSafeGesture.busy has error=${snapshot.error}',
            );
          }

          final isBusy = snapshot.data!;

          if (!isBusy) {
            final onTap = widget.onTap;

            return widget.builder(
              context,
              onTap == null
                  ? null
                  : () async => _tapSafeGestureHandler.onTap(
                        () async {
                          await onTap();

                          final cooldown = widget.cooldown;

                          if (cooldown != null) {
                            await Future<void>.delayed(cooldown);
                          }
                        },
                      ),
            );
          }

          final disabledChild = widget.builder(context, null);

          if (widget.waitBuilder == null) {
            return disabledChild;
          } else {
            return widget.waitBuilder!(context, disabledChild);
          }
        },
      );
}

/// Single TapSafeGesture
class _TapSafeGestureHandler {
  _TapSafeGestureHandler()
      : _busyController = StreamController<bool>()..add(false);

  final StreamController<bool> _busyController;

  /// Busy state stream
  Stream<bool> get busyStream => _busyController.stream;

  /// Dispose resources
  void dispose() => _busyController.close();

  /// Process onTap function
  Future<void> onTap(Future<void> Function() function) async {
    try {
      _add(true);
      await function();
    } finally {
      _add(false);
    }
  }

  void _add(bool value) {
    if (!_busyController.isClosed) {
      _busyController.add(value);
    }
  }
}
