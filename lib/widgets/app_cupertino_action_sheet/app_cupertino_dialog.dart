import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/app_responsive/app_responsive.dart';

class AppCupertinoDialog {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? message,
    Widget? content,
    List<Widget>? actions,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
    VoidCallback? onConfirm,
  }) {
    return showCupertinoDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        content: content ??
            (message != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(message, style: const TextStyle(fontSize: 13)),
                  )
                : null),
        actions: actions ??
            [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(ctx, null),
                child: Text(cancelText, style: const TextStyle(color: Colors.blue)),
              ),
              CupertinoDialogAction(
                isDestructiveAction: isDestructive,
                onPressed: () {
                  Navigator.pop(ctx, true as T);
                  onConfirm?.call();
                },
                child: Text(
                  confirmText,
                  style: TextStyle(
                    color: isDestructive ? Colors.red : Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
      ),
    );
  }

  static void delete({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = 'Delete',
  }) {
    show(
      context: context,
      title: title,
      message: message,
      confirmText: confirmText,
      isDestructive: true,
      onConfirm: onConfirm,
    );
  }

  static void success({
    required BuildContext context,
    required String title,
    String? message,
    String buttonText = 'Done',
    VoidCallback? onConfirm,
  }) {
    show(
      context: context,
      title: title,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_rounded, color: Colors.green, size: 45),
          if (message != null) ...[
            const RSizedBox(height: 10),
            Text(message, style: const TextStyle(fontSize: 13)),
          ],
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            onConfirm?.call();
          },
          child: Text(buttonText, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  static void info({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'Okay',
  }) {
    show(
      context: context,
      title: title,
      message: message,
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: Text(buttonText, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
