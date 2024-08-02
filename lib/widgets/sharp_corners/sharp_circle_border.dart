import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'sharp_rectangle_border.dart';

class SharpCircleBorder extends OutlinedBorder {
  const SharpCircleBorder({
    super.side,
    this.borderAlign = BorderAlign.inside,
  });

  final BorderAlign borderAlign;

  @override
  EdgeInsetsGeometry get dimensions {
    switch (borderAlign) {
      case BorderAlign.inside:
        return EdgeInsets.all(side.width);
      case BorderAlign.center:
        return EdgeInsets.all(side.width / 2);
      case BorderAlign.outside:
        return EdgeInsets.zero;
    }
  }

  @override
  ShapeBorder scale(double t) {
    return SharpCircleBorder(
      side: side.scale(t),
      borderAlign: borderAlign,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is SharpCircleBorder) {
      return SharpCircleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderAlign: borderAlign,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is SharpCircleBorder) {
      return SharpCircleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderAlign: borderAlign,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final innerRect = _adjustRect(rect, borderAlign, side.width);
    return Path()..addOval(innerRect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addOval(rect);
  }

  Rect _adjustRect(Rect rect, BorderAlign align, double width) {
    switch (align) {
      case BorderAlign.inside:
        return rect.deflate(width);
      case BorderAlign.center:
        return rect.deflate(width / 2);
      case BorderAlign.outside:
        return rect;
    }
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (rect.isEmpty) return;
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final adjustedRect = _adjustRect(rect, borderAlign, side.width);
        canvas.drawOval(adjustedRect, side.toPaint());
        break;
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is SharpCircleBorder &&
        other.side == side &&
        other.borderAlign == borderAlign;
  }

  @override
  int get hashCode => Object.hash(side, borderAlign);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'SharpCircleBorder')}($side, $borderAlign)';
  }

  @override
  SharpCircleBorder copyWith({
    BorderSide? side,
    // SharpBorderRadius? borderRadius,
    BorderAlign? borderAlign,
  }) {
    return SharpCircleBorder(
      side: side ?? this.side,
      // borderRadius: borderRadius ?? this.borderRadius,
      borderAlign: borderAlign ?? this.borderAlign,
    );
  }
}
