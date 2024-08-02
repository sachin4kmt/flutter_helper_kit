import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../flutter_tag_gradient.dart';
import '../flutter_tag_gradient_type.dart';
import 'flutter_calculation_utils.dart';

class FlutterGradientUtils {
  static Shader? getGradientShader({
    required FlutterTagGradient tagGradient,
    required double width,
    required double height,
  }) {
    switch (tagGradient.gradientType) {
      case FlutterTagGradientType.linear:
        return ui.Gradient.linear(
          FlutterCalculationUtils.calculateOffset(
            alignment: tagGradient.begin!,
            width: width,
            height: height,
          ),
          FlutterCalculationUtils.calculateOffset(
            alignment: tagGradient.end!,
            width: width,
            height: height,
          ),
          tagGradient.colors,
        );
      case FlutterTagGradientType.radial:
        return ui.Gradient.radial(
          FlutterCalculationUtils.calculateOffset(
            alignment: tagGradient.center!,
            width: width,
            height: height,
          ),
          width * tagGradient.radius!,
          tagGradient.colors,
        );
      case FlutterTagGradientType.sweep:
        return ui.Gradient.sweep(
          FlutterCalculationUtils.calculateOffset(
            alignment: tagGradient.center!,
            width: width,
            height: height,
          ),
          tagGradient.colors,
        );
      default:
        return null;
    }
  }
}
