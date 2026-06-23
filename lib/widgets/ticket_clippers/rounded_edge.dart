import 'package:flutter/material.dart';

import 'edge_enum.dart';

/// [RoundedEdgeClipper] that can be used with [ClipPath] to clip widget in Rounded Edge shape
///
class RoundedEdgeClipper extends CustomClipper<Path> {
  RoundedEdgeClipper({
    this.edge = Edge.bottom,
    this.points = 20,
    this.depth = 10,
  });

  /// Number of rounded edges
  final int points;

  /// Depth of rounded edge
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
    double c = w - depth;
    double i = h / points;

    if (edge == Edge.left || edge == Edge.horizontal || edge == Edge.all) {
      while (y < h) {
        path.quadraticBezierTo(depth, y + i / 2, 0, y + i);
        y += i;
      }
    }

    // Bottom or Vertical
    path.lineTo(0, h);
    x = 0;
    y = h;
    c = h - depth;
    i = w / points;

    if (edge == Edge.bottom || edge == Edge.vertical || edge == Edge.all) {
      while (x < w) {
        path.quadraticBezierTo(x + i / 2, c, x + i, y);
        x += i;
      }
    }

    // Right or Horizontal
    path.lineTo(w, h);
    x = w;
    y = h;
    c = w - depth;
    i = h / points;

    if (edge == Edge.right || edge == Edge.horizontal || edge == Edge.all) {
      while (y > 0) {
        path.quadraticBezierTo(c, y - i / 2, w, y - i);
        y -= i;
      }
    }

    // Top or Vertical
    path.lineTo(w, 0);
    x = w;
    y = 0;
    c = h - depth;
    i = w / points;

    if (edge == Edge.top || edge == Edge.vertical || edge == Edge.all) {
      while (x > 0) {
        path.quadraticBezierTo(x - i / 2, depth, x - i, 0);
        x -= i;
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
