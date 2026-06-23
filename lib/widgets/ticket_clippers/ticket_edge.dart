import 'package:flutter/material.dart';

import 'edge_enum.dart';

/// [TicketRoundedEdgeClipper] that can be used with [ClipPath] to clip widget in Ticket Rounded Edge shape
class TicketRoundedEdgeClipper extends CustomClipper<Path> {
  TicketRoundedEdgeClipper({
    this.edge = Edge.bottom,
    this.position = 20,
    this.radius = 15,
  });

  /// Position of rounded clipper
  double position;
  /// Radius of rounded edge
  final double radius;
  /// Clipper sides: Edge.horizontal, Edge.vertical, Edge.top, Edge.bottom, Edge.left, Edge.right, Edge.all
  final Edge edge;

  @override
  Path getClip(Size size) {
    var h = size.height;
    var w = size.width;
    position = position + (radius * 0.25);
    final path = Path();

    // Top or Vertical or All
    path.moveTo(0, 0);
    path.lineTo(position - radius, 0.0);
    if (edge == Edge.top || edge == Edge.vertical || edge == Edge.all) {
      path.arcToPoint(
        Offset(position, 0),
        clockwise: false,
        radius: const Radius.circular(1),
      );
    }

    // Right or Horizontal or All
    path.lineTo(w, 0.0);
    path.lineTo(w, position - radius);
    if (edge == Edge.right || edge == Edge.horizontal || edge == Edge.all) {
      path.arcToPoint(
        Offset(w, position),
        clockwise: false,
        radius: const Radius.circular(1),
      );
    }

    // Bottom or Vertical or All
    path.lineTo(w, h);
    path.lineTo(position, h);
    if (edge == Edge.bottom || edge == Edge.vertical || edge == Edge.all) {
      path.arcToPoint(
        Offset(position - radius, h),
        clockwise: false,
        radius: const Radius.circular(1),
      );
    }

    // Left or Horizontal or All
    path.lineTo(0.0, h);
    path.lineTo(0, position);
    if (edge == Edge.left || edge == Edge.horizontal || edge == Edge.all) {
      path.arcToPoint(
        Offset(0, position - radius),
        clockwise: false,
        radius: const Radius.circular(1),
      );
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
