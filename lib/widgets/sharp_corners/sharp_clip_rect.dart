import 'package:flutter/widgets.dart';

import 'sharp_border_radius.dart';
import 'sharp_rectangle_border.dart';

class SharpClipRect extends StatelessWidget {
  const SharpClipRect({
    super.key,
    required this.child,
    this.radius = SharpBorderRadius.zero,
    this.clipBehavior = Clip.antiAlias,
  });

  final SharpBorderRadius radius;
  final Clip clipBehavior;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath.shape(
      clipBehavior: clipBehavior,
      shape: SharpRectangleBorder(
        borderRadius: radius,
      ),
      child: child,
    );
  }
}
