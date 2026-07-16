import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/app_responsive/app_responsive.dart';

/// A circular container with equal width and height from [size].
///
/// Supports solid color or [gradient], responsive padding via [all]
/// (`REdgeInsets.all` + [RPadding]), and a full circular border via
/// [borderWidth] / [borderColor] or [border].
///
/// ```dart
/// CircleContainer(
///   size: 64,
///   all: 8,
///   gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
///   borderWidth: 2,
///   borderColor: Colors.white,
///   child: Icon(Icons.person, color: Colors.white),
/// )
/// ```
class CircleContainer extends StatelessWidget {
  const CircleContainer({
    super.key,
    this.size,
    this.paddingAll,
    this.child,
    this.color,
    this.gradient,
    this.border,
    this.borderWidth,
    this.borderColor,
    this.boxShadow,
    this.alignment = Alignment.center,
    this.margin,
    this.clipBehavior = Clip.antiAlias,
    this.image,
    this.foregroundDecoration,
    this.constraints,
  });

  /// Diameter of the circle (width and height are equal).
  final double? size;

  /// Uniform responsive padding on all sides (`REdgeInsets.all` via [RPadding]).
  final double? paddingAll;

  /// Content inside the circle.
  final Widget? child;

  /// Solid background color. Ignored when [gradient] is set.
  final Color? color;

  /// Background gradient. Takes priority over [color].
  final Gradient? gradient;

  /// Custom border. When null, built from [borderWidth] and [borderColor].
  final Border? border;

  /// Width for [Border.all] when [border] is null.
  final double? borderWidth;

  /// Color for [Border.all] when [border] is null.
  final Color? borderColor;

  /// Optional shadows around the circle.
  final List<BoxShadow>? boxShadow;

  /// Alignment of [child] inside the circle.
  final AlignmentGeometry alignment;

  /// Outer margin around the circle.
  final EdgeInsetsGeometry? margin;

  /// How to clip overflowing content. Default is [Clip.antiAlias].
  final Clip clipBehavior;

  /// Optional background image (clipped to the circle).
  final DecorationImage? image;

  /// Optional decoration drawn in front of [child]. Forced to [BoxShape.circle]
  /// when a [BoxDecoration] is provided.
  final Decoration? foregroundDecoration;

  /// Optional size constraints. Defaults to a square of [size].
  final BoxConstraints? constraints;

  Border? get _resolvedBorder {
    if (border != null) return border;
    if (borderWidth != null || borderColor != null) {
      return Border.all(
          width: borderWidth ?? 1, color: borderColor ?? Colors.black12);
    }
    return null;
  }

  Decoration? get _resolvedForegroundDecoration {
    final decoration = foregroundDecoration;
    if (decoration is BoxDecoration) {
      return decoration.copyWith(shape: BoxShape.circle, borderRadius: null);
    }
    return decoration;
  }

  Widget? get _paddedChild {
    if (child == null && paddingAll == null) return null;
    if (paddingAll == null) return child;

    return RPadding(
        padding: REdgeInsets.all(paddingAll!),
        child: child ?? const SizedBox.shrink());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: margin,
      alignment: alignment,
      clipBehavior: clipBehavior,
      constraints: constraints,
      foregroundDecoration: _resolvedForegroundDecoration,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: gradient == null ? color : null,
        gradient: gradient,
        border: _resolvedBorder,
        boxShadow: boxShadow,
        image: image,
      ),
      child: _paddedChild,
    );
  }
}
