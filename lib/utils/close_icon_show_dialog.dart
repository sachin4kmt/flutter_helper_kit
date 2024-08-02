import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

Future<void> showDialogWithCloseIcon({
  required BuildContext context,

  ///title Button
  required Widget title,

  ///content Button
  required Widget content,

  ///Close Button
  Widget? closeIcon,
  EdgeInsets? insetPadding,
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  FlutterTagPosition? closeButtonPosition,
  FlutterTagAnimation? closeButtonAnimation,
  FlutterTagStyle? closeButtonStyle,
  Color? backgroundColor,
  Color? dialogColor,
  SharpRectangleBorder? shape,
}) async {
  return showDialog<void>(
    context: context,
    useRootNavigator: useRootNavigator,
    barrierDismissible: barrierDismissible,
    barrierColor: backgroundColor,
    builder: (BuildContext ctx) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: FlutterTag(
          tagStyle: closeButtonStyle ??
              const FlutterTagStyle(
                  tagColor: Colors.red, shape: FlutterTagShape.circle),
          stackFit: StackFit.passthrough,
          position: closeButtonPosition ?? FlutterTagPosition.topStart(),
          tagAnimation: closeButtonAnimation ??
              const FlutterTagAnimation.rotation(toAnimate: false),
          onTap: () {
            Navigator.of(context).pop();
          },
          tagContent: closeIcon ??
              const Icon(
                Icons.close,
                color: Colors.white,
              ),
          child: Card(
            shape: shape,
            borderOnForeground: false,
            color: dialogColor,
            child: Padding(
              padding: insetPadding ?? const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  title,
                  20.maxSpace,
                  content,
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
