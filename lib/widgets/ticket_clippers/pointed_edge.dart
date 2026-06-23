import 'package:flutter/material.dart';

import 'edge_enum.dart';

/// [PointedEdgeClipper] that can be used with [ClipPath] to clip widget in Pointed Edge shape

class PointedEdgeClipper extends CustomClipper<Path> {
  PointedEdgeClipper({
    this.edge = Edge.bottom,
    this.points = 20,
    this.depth = 10,
  });

  /// Number of point edges
  final int points;

  /// Depth of pointed edge
  final double depth;

  /// Clipper sides: Edge.horizontal, Edge.vertical, Edge.top, Edge.bottom, Edge.left, Edge.right, Edge.all
  final Edge edge;
  @override
  Path getClip(Size size) {
    var h = size.height;
    var w = size.width;
    Path path = Path();

    // Left or Horizontal
    path.moveTo(0, 0);
    double x = 0;
    double y = 0;
    double i = h / points;

    if (edge == Edge.left || edge == Edge.horizontal || edge == Edge.all) {
      while (y < h) {
        y += i;
        x = (x == 0) ? depth : 0;
        path.lineTo(x, y);
      }
    }

    // Bottom or Vertical
    path.lineTo(0, h);
    x = 0;
    y = h;
    i = w / points;

    if (edge == Edge.bottom || edge == Edge.vertical || edge == Edge.all) {
      while (x < w) {
        x += i;
        y = (y == h) ? h - depth : h;
        path.lineTo(x, y);
      }
    }

    // Right or Horizontal
    path.lineTo(w, h);
    x = w;
    y = h;
    i = h / points;

    if (edge == Edge.right || edge == Edge.horizontal || edge == Edge.all) {
      while (y > 0) {
        y -= i;
        x = (x == w) ? w - depth : w;
        path.lineTo(x, y);
      }
    }

    // Top or Vertical
    path.lineTo(w, 0);
    x = w;
    y = 0;
    i = w / points;

    if (edge == Edge.top || edge == Edge.vertical || edge == Edge.all) {
      while (x > 0) {
        x -= i;
        y = (y == 0) ? depth : 0;
        path.lineTo(x, y);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
