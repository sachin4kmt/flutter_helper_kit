import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'flutter_tag_gradient_type.dart';

/// A utility class for creating gradients of various types used in Flutter badges.
class FlutterTagGradient {
  /// The starting alignment of the gradient, only applicable for [linear] gradients.
  final AlignmentGeometry? begin;

  /// The ending alignment of the gradient, only applicable for [linear] gradients.
  final AlignmentGeometry? end;

  /// Determines how the gradient is tiled when its bounds exceed the gradient's bounds.
  final TileMode tileMode;

  /// A list of colors that define the gradient.
  final List<Color> colors;

  /// Optional list of stops that indicate the color stop positions.
  final List<double>? stops;

  /// Optional transformation to apply to the gradient.
  final GradientTransform? transform;

  /// The center alignment of the gradient, only applicable for [radial] and [sweep] gradients.
  final AlignmentGeometry? center;

  /// The radius of the gradient, only applicable for [radial] gradients.
  final double? radius;

  /// The focal point of the gradient, only applicable for [radial] gradients.
  final AlignmentGeometry? focal;

  /// The focal radius for the gradient, only applicable for [radial] gradients.
  final double? focalRadius;

  /// The start angle of the gradient, only applicable for [sweep] gradients.
  final double? startAngle;

  /// The end angle of the gradient, only applicable for [sweep] gradients.
  final double? endAngle;

  /// The type of gradient (linear, radial, or sweep).
  final FlutterTagGradientType gradientType;

  /// Constructs a linear gradient.
  const FlutterTagGradient.linear({
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    required this.colors,
    this.stops,
    this.tileMode = TileMode.clamp,
    this.transform,
  })  : gradientType = FlutterTagGradientType.linear,
        center = null,
        radius = null,
        focal = null,
        focalRadius = null,
        startAngle = null,
        endAngle = null;

  /// Constructs a radial gradient.
  const FlutterTagGradient.radial({
    this.center = Alignment.center,
    required this.colors,
    this.radius = 0.5,
    this.stops,
    this.tileMode = TileMode.clamp,
    this.focal,
    this.focalRadius = 0.0,
    this.transform,
  })  : gradientType = FlutterTagGradientType.radial,
        begin = null,
        end = null,
        startAngle = null,
        endAngle = null;

  /// Constructs a sweep gradient.
  const FlutterTagGradient.sweep({
    this.tileMode = TileMode.clamp,
    required this.colors,
    this.center = Alignment.center,
    this.startAngle = 0.0,
    this.endAngle = math.pi * 2,
    this.stops,
    this.transform,
  })  : gradientType = FlutterTagGradientType.sweep,
        begin = null,
        end = null,
        radius = null,
        focal = null,
        focalRadius = null;

  /// Returns the appropriate [Gradient] object based on the gradient type.
  Gradient gradient() {
    switch (gradientType) {
      case FlutterTagGradientType.linear:
        // Creates a linear gradient with specified properties.
        return LinearGradient(
          colors: colors,
          begin: begin!,
          end: end!,
          stops: stops,
          tileMode: tileMode,
          transform: transform,
        );
      case FlutterTagGradientType.radial:
        // Creates a radial gradient with specified properties.
        return RadialGradient(
          colors: colors,
          radius: radius!,
          center: center!,
          stops: stops,
          tileMode: tileMode,
          focal: focal,
          focalRadius: focalRadius!,
          transform: transform,
        );
      case FlutterTagGradientType.sweep:
        // Creates a sweep gradient with specified properties.
        return SweepGradient(
          colors: colors,
          center: center!,
          startAngle: startAngle!,
          endAngle: endAngle!,
          stops: stops,
          tileMode: tileMode,
          transform: transform,
        );
     /* default:
        // Default to linear gradient if the type is not recognized.
        return LinearGradient(
          colors: colors,
          begin: begin!,
          end: end!,
          stops: stops,
          tileMode: tileMode,
          transform: transform,
        );*/
    }
  }
}
