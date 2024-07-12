import 'package:flutter/material.dart';

enum FlutterToastPosition {
  bottom(0),
  center(1),
  top(2);

  final int value;

  const FlutterToastPosition(this.value);
}

/// the package library class for calling from client end.
class FlutterToast {
  static const Duration lengthShort = Duration(seconds: 1);

  /// a fixed length to show toast message
  static const Duration lengthLong = Duration(seconds: 2);

  /// a fixed length to show toast message
  static const int bottom = 0;

  /// a fixed value for toast message position
  static const int center = 1;

  /// a fixed value for toast message position
  static const int top = 2;

  /// a fixed value for toast message position
  /// method to show the toast message
  static void show(
    String msg,
    BuildContext context, {
    Duration? duration = const Duration(seconds: 1),

    /// duration : how long do you want to show the message
    FlutterToastPosition position = FlutterToastPosition.bottom,

    /// position : where do you want to show the toast message, you can pass bottom, center, top or any defined value
    Color backgroundColor = const Color(0xAA000000),

    /// defines the background color of toast message
    textStyle = const TextStyle(fontSize: 15, color: Colors.white),

    /// for toast message styling
    double backgroundRadius = 20,

    /// you can apply toast message background radius
    bool? rootNavigator,
    Border? border,

    /// you can specify background border
  }) {
    _FlutterToastView.dismiss();
    _FlutterToastView.createView(msg, context, duration, position,
        backgroundColor, textStyle, backgroundRadius, border, rootNavigator);
  }

  /// a fixed value for toast message position
  /// method to show the toast message
}

class _FlutterToastView {
  static final _FlutterToastView _singleton = _FlutterToastView._internal();

  factory _FlutterToastView() {
    return _singleton;
  }

  _FlutterToastView._internal();

  static OverlayState? overlayState;
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void createView(
      String msg,

      /// the message you want to show as toast
      BuildContext context,
      Duration? duration,

      /// duration : how long do you want to show the message
      FlutterToastPosition? position,

      /// position : where do you want to show the toast message, you can pass bottom, center, top or any defined value
      Color background,

      /// defines the background color of toast message
      TextStyle textStyle,

      /// for toast message styling
      double backgroundRadius,

      /// you can apply toast message background radius
      Border? border,

      /// you can specify background border
      bool? rootNavigator) async {
    overlayState = Overlay.of(context, rootOverlay: rootNavigator ?? false);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _FlutterToastWidget(
          widget: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(backgroundRadius),
                    border: border,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Text(msg, softWrap: true, style: textStyle),
                )),
          ),
          position: (position?.value ?? FlutterToastPosition.bottom.value)),
    );
    _isVisible = true;
    overlayState!.insert(_overlayEntry!);
    await Future.delayed(duration ?? FlutterToast.lengthShort);
    dismiss();
  }

  /// dismisses the toast message after the duration provided
  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

/// the widget to implement the toast message
class _FlutterToastWidget extends StatelessWidget {
  const _FlutterToastWidget({
    required this.widget,
    required this.position,
  });

  final Widget widget;
  final int? position;

  @override
  Widget build(BuildContext context) {
    /// showing the toast message
    return Positioned(
        top: position == 2 ? MediaQuery.of(context).viewInsets.top + 50 : null,
        bottom: position == 0
            ? MediaQuery.of(context).viewInsets.bottom + 50
            : null,
        child: Material(
          color: Colors.transparent,
          child: widget,
        ));
  }
}
