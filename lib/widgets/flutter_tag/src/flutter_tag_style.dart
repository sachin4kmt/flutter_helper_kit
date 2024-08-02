import 'package:flutter/material.dart';

import '../../sharp_corners/sharp.dart';
import 'flutter_tag_gradient.dart';
import 'flutter_tag_shape.dart';

class FlutterTagStyle {
  /// Allows to set the shape to this [tagContent].
  /// The default value is [FlutterTagShape.circle].
  final FlutterTagShape shape;

  /// Allows to set border radius to this [tagContent].
  /// The default value is [BorderRadius.zero].
  final SharpBorderRadius borderRadius;

  /// Background color of the tag.
  /// If [gradient] is not null, this property will be ignored.
  final Color tagColor;

  /// Allows to set border side to this [tagContent].
  /// The default value is [BorderSide.none].
  final BorderSide borderSide;

  /// The size of the shadow below the tag.
  final double elevation;

  /// Background gradient color of the tag.
  /// Will be used over [tagColor] if not null.
  final FlutterTagGradient? tagGradient;

  /// Background gradient color of the border tag.
  /// Will be used over [borderSide.color] if not null.
  final FlutterTagGradient? borderGradient;

  /// Specifies padding for [tagContent].
  /// The default value is EdgeInsets.all(5.0).
  final EdgeInsetsGeometry padding;
  const FlutterTagStyle({
    this.shape = FlutterTagShape.circle,
    this.borderRadius = SharpBorderRadius.zero,
    this.tagColor = Colors.red,
    this.borderSide = BorderSide.none,
    this.elevation = 2,
    this.tagGradient,
    this.borderGradient,
    this.padding = const EdgeInsets.all(5.0),
  }) : super();

  FlutterTagStyle copyWith(
      {FlutterTagShape? shape,
      SharpBorderRadius? borderRadius,
      Color? tagColor,
      BorderSide? borderSide,
      double? elevation,
      FlutterTagGradient? tagGradient,
      FlutterTagGradient? borderGradient,
      EdgeInsetsGeometry? padding}) {
    return FlutterTagStyle(
      shape: shape ?? this.shape,
      borderRadius: borderRadius ?? this.borderRadius,
      tagColor: tagColor ?? this.tagColor,
      borderSide: borderSide ?? this.borderSide,
      elevation: elevation ?? this.elevation,
      tagGradient: tagGradient ?? this.tagGradient,
      borderGradient: borderGradient ?? this.borderGradient,
      padding: padding ?? this.padding,
    );
  }
}
