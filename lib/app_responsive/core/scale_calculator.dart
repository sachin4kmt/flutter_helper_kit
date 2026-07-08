import 'dart:math';

import 'package:flutter/material.dart';

typedef FontSizeResolver = double Function(num fontSize);

/// Pure scaling math for responsive layouts.
///
/// Keeps adaptation logic isolated from widget/state management so it can be
/// tested and reused through [ScreenUtil] or [ResponsiveScope].
class ScaleCalculator {
  const ScaleCalculator({
    required this.designSize,
    required this.deviceSize,
    this.minTextAdapt = false,
    this.splitScreenMode = false,
    this.splitScreenMinHeight = ScreenUtilDefaults.splitScreenMinHeight,
    this.enableScaleWidth = true,
    this.enableScaleHeight = true,
    this.enableScaleText = true,
  });

  final Size designSize;
  final Size deviceSize;
  final bool minTextAdapt;
  final bool splitScreenMode;
  final double splitScreenMinHeight;
  final bool enableScaleWidth;
  final bool enableScaleHeight;
  final bool enableScaleText;

  double get scaleWidth =>
      !enableScaleWidth ? 1 : deviceSize.width / designSize.width;

  double get scaleHeight {
    if (!enableScaleHeight) return 1;
    final effectiveHeight = splitScreenMode
        ? max(deviceSize.height, splitScreenMinHeight)
        : deviceSize.height;
    return effectiveHeight / designSize.height;
  }

  double get scaleText {
    if (!enableScaleText) return 1;
    return minTextAdapt ? min(scaleWidth, scaleHeight) : scaleWidth;
  }

  double width(num value) => value * scaleWidth;

  double height(num value) => value * scaleHeight;

  double radius(num value) => value * min(scaleWidth, scaleHeight);

  double diagonal(num value) => value * scaleHeight * scaleWidth;

  double diameter(num value) => value * max(scaleWidth, scaleHeight);

  double sp(num fontSize, {FontSizeResolver? fontSizeResolver}) =>
      fontSizeResolver?.call(fontSize) ?? fontSize * scaleText;

  ScaleCalculator copyWith({
    Size? designSize,
    Size? deviceSize,
    bool? minTextAdapt,
    bool? splitScreenMode,
    double? splitScreenMinHeight,
    bool? enableScaleWidth,
    bool? enableScaleHeight,
    bool? enableScaleText,
  }) {
    return ScaleCalculator(
      designSize: designSize ?? this.designSize,
      deviceSize: deviceSize ?? this.deviceSize,
      minTextAdapt: minTextAdapt ?? this.minTextAdapt,
      splitScreenMode: splitScreenMode ?? this.splitScreenMode,
      splitScreenMinHeight: splitScreenMinHeight ?? this.splitScreenMinHeight,
      enableScaleWidth: enableScaleWidth ?? this.enableScaleWidth,
      enableScaleHeight: enableScaleHeight ?? this.enableScaleHeight,
      enableScaleText: enableScaleText ?? this.enableScaleText,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScaleCalculator &&
          runtimeType == other.runtimeType &&
          designSize == other.designSize &&
          deviceSize == other.deviceSize &&
          minTextAdapt == other.minTextAdapt &&
          splitScreenMode == other.splitScreenMode &&
          splitScreenMinHeight == other.splitScreenMinHeight &&
          enableScaleWidth == other.enableScaleWidth &&
          enableScaleHeight == other.enableScaleHeight &&
          enableScaleText == other.enableScaleText;

  @override
  int get hashCode => Object.hash(
        designSize,
        deviceSize,
        minTextAdapt,
        splitScreenMode,
        splitScreenMinHeight,
        enableScaleWidth,
        enableScaleHeight,
        enableScaleText,
      );
}

/// Shared defaults for responsive scaling.
abstract final class ScreenUtilDefaults {
  static const Size designSize = Size(360, 690);
  static const double splitScreenMinHeight = 700;
}
