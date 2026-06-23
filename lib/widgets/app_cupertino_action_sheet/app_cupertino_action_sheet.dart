import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/app_responsive/app_responsive.dart';

/// Generic model for action sheet items.
class ActionSheetItem<T> {
  final T value;
  final String label;
  final IconData? icon;
  final Color? color;
  final bool isDestructive;
  final VoidCallback? onPressed;

  ActionSheetItem({
    required this.value,
    required this.label,
    this.icon,
    this.color,
    this.isDestructive = false,
    this.onPressed,
  });
}

class AppCupertinoActionSheet {
  static Future<T?> showActionSheet<T>({
    required BuildContext context,
    String? title,
    String? message,
    String cancelButtonText = 'Cancel',
    required List<ActionSheetItem<T>> actions,
  }) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (ctx) {
        return CupertinoActionSheet(
          title: title != null
              ? Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
              : null,
          message: message != null
              ? Text(message, style: const TextStyle(fontSize: 13))
              : null,
          actions: actions.map((action) {
            final displayColor = action.color ?? (action.isDestructive ? Colors.red : Colors.blue);

            return CupertinoActionSheetAction(
              isDestructiveAction: action.isDestructive,
              onPressed: () {
                Navigator.pop(ctx, action.value);
                action.onPressed?.call();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (action.icon != null) ...[
                    Icon(action.icon, color: displayColor, size: 22.sp),
                    const RSizedBox(width: 12),
                  ],
                  Text(action.label, style: TextStyle(color: displayColor, fontSize: 16)),
                ],
              ),
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              cancelButtonText,
              style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }
}
