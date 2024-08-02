import 'dart:math' as math;

import 'sharp_radius.dart';

const double _degrees2Radians = math.pi / 180.0;
double _radians(double degrees) => degrees * _degrees2Radians;

class SharpProcessedRadius {
  const SharpProcessedRadius._({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.p,
    required this.width,
    required this.height,
    required this.radius,
    required this.circularSectionLength,
  });

  factory SharpProcessedRadius(
    SharpRadius radius, {
    required double width,
    required double height,
  }) {
    final sharpRatio = radius.sharpRatio;
    var cornerRadius = radius.cornerRadius;

    final maxRadius = math.min(width, height) / 2;
    cornerRadius = math.min(cornerRadius, maxRadius);

    // 12.2 from the article
    final p = math.min((1 + sharpRatio) * cornerRadius, maxRadius);

    final double angleAlpha, angleBeta;

    if (cornerRadius <= maxRadius / 2) {
      angleBeta = 90 * (1 - sharpRatio);
      angleAlpha = 45 * sharpRatio;
    } else {
      // When `cornerRadius` is larger and `maxRadius / 2`,
      // these angles also depend on `cornerRadius` and `maxRadius / 2`
      //
      // I did a few tests in Figma and this code generated similar but not identical results
      // `diffRatio` was called `change_percentage` in the orignal code
      final diffRatio = (cornerRadius - maxRadius / 2) / (maxRadius / 2);

      angleBeta = 90 * (1 - sharpRatio * (1 - diffRatio));
      angleAlpha = 45 * sharpRatio * (1 - diffRatio);
    }

    final angleTheta = (90 - angleBeta) / 2;

    // This was called `h_longest` in the original code
    // In the article this is the distance between 2 control points: P3 and P4
    final p3ToP4Distance = cornerRadius * math.tan(_radians(angleTheta / 2));

    // This was called `l` in the original code
    final circularSectionLength =
        math.sin(_radians(angleBeta / 2)) * cornerRadius * math.sqrt(2);

    // a, b, c and d are from 11.1 in the article
    final c = p3ToP4Distance * math.cos(_radians(angleAlpha));
    final d = c * math.tan(_radians(angleAlpha));
    final b = (p - circularSectionLength - c - d) / 3;
    final a = 2 * b;

    return SharpProcessedRadius._(
      a: a,
      b: b,
      c: c,
      d: d,
      p: p,
      width: width,
      height: height,
      radius: SharpRadius(
        cornerRadius: cornerRadius,
        sharpRatio: radius.sharpRatio,
      ),
      circularSectionLength: circularSectionLength,
    );
  }

  final SharpRadius radius;
  final double a;
  final double b;
  final double c;
  final double d;
  final double p;
  final double circularSectionLength;
  final double width;
  final double height;
  double get cornerRadius => radius.cornerRadius;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    if (other is SharpRadius) {
      return other == radius;
    }
    if (other is SharpProcessedRadius) {
      return other.radius == radius;
    }

    return false;
  }

  @override
  int get hashCode => radius.hashCode;

  @override
  String toString() {
    return 'FlutterProcessedRadius('
        'radius: $radius,'
        'a: ${a.toStringAsFixed(2)},'
        'b: ${b.toStringAsFixed(2)},'
        'c: ${c.toStringAsFixed(2)},'
        'd: ${d.toStringAsFixed(2)},'
        'p: ${p.toStringAsFixed(2)},'
        'width: ${width.toStringAsFixed(2)},'
        'height: ${height.toStringAsFixed(2)},'
        ')';
  }
}
