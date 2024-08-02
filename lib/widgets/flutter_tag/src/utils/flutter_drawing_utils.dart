import 'package:flutter/material.dart';

import '../flutter_tag_gradient.dart';
import '../flutter_tag_shape.dart';
import '../painters/flutter_cloud_tag_shape_painter.dart';
import '../painters/flutter_diamond_tag_shape_painter.dart';
import '../painters/flutter_hexagon_tag_shape_painter.dart';
import '../painters/flutter_pentagon_tag_shape_painter.dart';
import '../painters/flutter_star_tag_shape_painter.dart';

class FlutterDrawingUtils {
  static CustomPainter? drawTagShape({
    required FlutterTagShape shape,
    Color? color,
    FlutterTagGradient? tagGradient,
    FlutterTagGradient? borderGradient,
    BorderSide? borderSide,
  }) {
    final painterFactories = {
      FlutterTagShape.cloud: () => FlutterCloudTagShapePainter(
            color: color ?? Colors.blue,
            tagGradient: tagGradient,
            borderSide: borderSide,
            borderGradient: borderGradient,
          ),
      FlutterTagShape.star: () => FlutterStarTagShapePainter(
            color: color ?? Colors.blue,
            tagGradient: tagGradient,
            borderSide: borderSide,
            borderGradient: borderGradient,
          ),
      FlutterTagShape.diamond: () => FlutterDiamondTagShapePainter(
            color: color ?? Colors.blue,
            tagGradient: tagGradient,
            borderSide: borderSide,
            borderGradient: borderGradient,
          ),
      FlutterTagShape.hexagon: () => FlutterHexagonTagShapePainter(
            color: color ?? Colors.blue,
            tagGradient: tagGradient,
            borderSide: borderSide,
            borderGradient: borderGradient,
          ),
      FlutterTagShape.pentagon: () => FlutterPentagonTagShapePainter(
            color: color ?? Colors.blue,
            tagGradient: tagGradient,
            borderSide: borderSide,
            borderGradient: borderGradient,
          ),
      // Add other shapes here if needed
    };

    return painterFactories[shape]?.call();
  }
}
