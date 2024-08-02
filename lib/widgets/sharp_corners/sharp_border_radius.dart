import 'package:flutter/rendering.dart';
import 'package:flutter_helper_kit/widgets/sharp_corners/sharp.dart';

class SharpBorderRadius extends BorderRadius {
  SharpBorderRadius({
    required double cornerRadius,
    double sharpRatio = 0,
  }) : this.only(
          topLeft: SharpRadius(
            cornerRadius: cornerRadius,
            sharpRatio: sharpRatio,
          ),
          topRight: SharpRadius(
            cornerRadius: cornerRadius,
            sharpRatio: sharpRatio,
          ),
          bottomLeft: SharpRadius(
            cornerRadius: cornerRadius,
            sharpRatio: sharpRatio,
          ),
          bottomRight: SharpRadius(
            cornerRadius: cornerRadius,
            sharpRatio: sharpRatio,
          ),
        );

  /// Creates a border radius where all radii are [radius].

  const SharpBorderRadius.all(SharpRadius radius)
      : this.only(
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        );

  /// Creates a vertically symmetric border radius where the top and bottom
  /// sides of the rectangle have the same radii.
  const SharpBorderRadius.vertical({
    SharpRadius top = SharpRadius.zero,
    SharpRadius bottom = SharpRadius.zero,
  }) : this.only(
          topLeft: top,
          topRight: top,
          bottomLeft: bottom,
          bottomRight: bottom,
        );

  /// Creates a horizontally symmetrical border radius where the left and right
  /// sides of the rectangle have the same radii.
  const SharpBorderRadius.horizontal({
    SharpRadius left = SharpRadius.zero,
    SharpRadius right = SharpRadius.zero,
  }) : this.only(
          topLeft: left,
          topRight: right,
          bottomLeft: left,
          bottomRight: right,
        );

  /// Creates a border radius with only the given non-zero values. The other
  /// corners will be right angles.
  const SharpBorderRadius.only({
    this.topLeft = SharpRadius.zero,
    this.topRight = SharpRadius.zero,
    this.bottomLeft = SharpRadius.zero,
    this.bottomRight = SharpRadius.zero,
  }) : super.only(
          topLeft: topLeft,
          bottomRight: topRight,
          topRight: topRight,
          bottomLeft: bottomLeft,
        );

  /// Returns a copy of this BorderRadius with the given fields replaced with
  /// the new values.
  @override
  SharpBorderRadius copyWith({
    Radius? topLeft,
    Radius? topRight,
    Radius? bottomLeft,
    Radius? bottomRight,
  }) {
    return SharpBorderRadius.only(
      topLeft: topLeft is SharpRadius ? topLeft : this.topLeft,
      topRight: topRight is SharpRadius ? topRight : this.topRight,
      bottomLeft: bottomLeft is SharpRadius ? bottomLeft : this.bottomLeft,
      bottomRight: bottomRight is SharpRadius ? bottomRight : this.bottomRight,
    );
  }

  /// A border radius with all zero radii.
  static const SharpBorderRadius zero = SharpBorderRadius.all(SharpRadius.zero);

  /// The top-left [SharpRadius].
  @override
  final SharpRadius topLeft;

  /// The top-right [SharpRadius].
  @override
  final SharpRadius topRight;

  /// The bottom-left [SharpRadius].
  @override
  final SharpRadius bottomLeft;

  /// The bottom-right [SharpRadius].
  @override
  final SharpRadius bottomRight;

  /// Creates a [Path] inside the given [Rect].
  Path toPath(Rect rect) {
    final width = rect.width;
    final height = rect.height;

    final result = Path();

    /// Calculating only if values are different
    final processedTopLeft = SharpProcessedRadius(
      topLeft,
      width: width,
      height: height,
    );
    final processedBottomLeft = topLeft == bottomLeft
        ? processedTopLeft
        : SharpProcessedRadius(
            bottomLeft,
            width: width,
            height: height,
          );
    final processedBottomRight = bottomLeft == bottomRight
        ? processedBottomLeft
        : SharpProcessedRadius(
            bottomRight,
            width: width,
            height: height,
          );
    final processedTopRight = topRight == bottomRight
        ? processedBottomRight
        : SharpProcessedRadius(
            topRight,
            width: width,
            height: height,
          );

    result
      ..addSharpTopRight(processedTopRight, rect)
      ..addSharpBottomRight(processedBottomRight, rect)
      ..addSharpBottomLeft(processedBottomLeft, rect)
      ..addSharpTopLeft(processedTopLeft, rect);

    return result.transform(
      Matrix4.translationValues(rect.left, rect.top, 0).storage,
    );
  }

  @override
  BorderRadiusGeometry subtract(BorderRadiusGeometry other) {
    if (other is SharpBorderRadius) return this - other;
    return super.subtract(other);
  }

  @override
  BorderRadiusGeometry add(BorderRadiusGeometry other) {
    if (other is SharpBorderRadius) return this + other;
    return super.add(other);
  }

  /// Returns the difference between two [BorderRadius] objects.
  @override
  SharpBorderRadius operator -(BorderRadius other) {
    if (other is SharpBorderRadius) {
      return SharpBorderRadius.only(
        topLeft: (topLeft - other.topLeft) as SharpRadius,
        topRight: (topRight - other.topRight) as SharpRadius,
        bottomLeft: (bottomLeft - other.bottomLeft) as SharpRadius,
        bottomRight: (bottomRight - other.bottomRight) as SharpRadius,
      );
    }

    return this;
  }

  /// Returns the sum of two [BorderRadius] objects.
  @override
  SharpBorderRadius operator +(BorderRadius other) {
    if (other is SharpBorderRadius) {
      return SharpBorderRadius.only(
        topLeft: (topLeft + other.topLeft) as SharpRadius,
        topRight: (topRight + other.topRight) as SharpRadius,
        bottomLeft: (bottomLeft + other.bottomLeft) as SharpRadius,
        bottomRight: (bottomRight + other.bottomRight) as SharpRadius,
      );
    }
    return this;
  }

  /// Returns the [BorderRadius] object with each corner negated.
  ///
  /// This is the same as multiplying the object by -1.0.
  @override
  SharpBorderRadius operator -() {
    return SharpBorderRadius.only(
      topLeft: (-topLeft) as SharpRadius,
      topRight: (-topRight) as SharpRadius,
      bottomLeft: (-bottomLeft) as SharpRadius,
      bottomRight: (-bottomRight) as SharpRadius,
    );
  }

  /// Scales each corner of the [BorderRadius] by the given factor.
  @override
  SharpBorderRadius operator *(double other) {
    return SharpBorderRadius.only(
      topLeft: topLeft * other,
      topRight: topRight * other,
      bottomLeft: bottomLeft * other,
      bottomRight: bottomRight * other,
    );
  }

  /// Divides each corner of the [BorderRadius] by the given factor.
  @override
  SharpBorderRadius operator /(double other) {
    return SharpBorderRadius.only(
      topLeft: topLeft / other,
      topRight: topRight / other,
      bottomLeft: bottomLeft / other,
      bottomRight: bottomRight / other,
    );
  }

  /// Integer divides each corner of the [BorderRadius] by the given factor.
  @override
  SharpBorderRadius operator ~/(double other) {
    return SharpBorderRadius.only(
      topLeft: topLeft ~/ other,
      topRight: topRight ~/ other,
      bottomLeft: bottomLeft ~/ other,
      bottomRight: bottomRight ~/ other,
    );
  }

  /// Computes the remainder of each corner by the given factor.
  @override
  SharpBorderRadius operator %(double other) {
    return SharpBorderRadius.only(
      topLeft: topLeft % other,
      topRight: topRight % other,
      bottomLeft: bottomLeft % other,
      bottomRight: bottomRight % other,
    );
  }

  /// Linearly interpolate between two [BorderRadius] objects.
  ///
  /// If either is null, this function interpolates from [BorderRadius.zero].
  ///
  /// {@macro dart.ui.shadow.lerp}
  static SharpBorderRadius? lerp(
      SharpBorderRadius? a, SharpBorderRadius? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b! * t;
    if (b == null) return a * (1.0 - t);
    return SharpBorderRadius.only(
      topLeft: SharpRadius.lerp(a.topLeft, b.topLeft, t)!,
      topRight: SharpRadius.lerp(a.topRight, b.topRight, t)!,
      bottomLeft: SharpRadius.lerp(a.bottomLeft, b.bottomLeft, t)!,
      bottomRight: SharpRadius.lerp(a.bottomRight, b.bottomRight, t)!,
    );
  }

  @override
  BorderRadius resolve(TextDirection? direction) => BorderRadius.only(
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
      );

  @override
  String toString() {
    if (topLeft == topRight &&
        topLeft == bottomRight &&
        topLeft == bottomLeft) {
      final radius = topLeft.toString();
      return 'SharpBorderRadius ${radius.substring(12)}';
    }

    return 'SharpBorderRadius ('
        'topLeft: $topLeft,'
        'topRight: $topRight,'
        'bottomLeft: $bottomLeft,'
        'bottomRight: $bottomRight,'
        ')';
  }
}
