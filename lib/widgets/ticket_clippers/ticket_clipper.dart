import 'package:flutter/material.dart';
import 'shadow_radius.dart';
import 'ticket_painter.dart';

class TicketClipper extends StatelessWidget {
  const TicketClipper({super.key,required this.clipper, this.shadow, required this.child,
  this.shadowRadius});
  /// - [TicketRoundedEdgeClipper] that can be used with [ClipPath] to clip widget in Ticket Rounded Edge shape
  /// - [PointedEdgeClipper] that can be used with [ClipPath] to clip widget in Pointed Edge shape
  /// - [RoundedEdgeClipper] that can be used with [ClipPath] to clip widget in Rounded Edge shape
  final CustomClipper<Path> clipper;
  /// child: [Widget]
  final Widget child;
  /// shadows: [BoxShadow?]
  final BoxShadow? shadow;
  /// shadowRadius: If non-null, the corners of this box shadow are rounded by this [ShadowRadius]
  /// - ShadowRadius.all(Radius radius)
  /// - ShadowRadius.circular(double radius)
  /// - ShadowRadius.horizontal(Radius left, Radius right)
  /// - ShadowRadius.vertical(Radius top, Radius bottom)
  /// - ShadowRadius.only(Radius topLeft, Radius topRight, Radius bottomLeft, Radius bottomRight)
  /// - ShadowRadius.zero
  final ShadowRadius? shadowRadius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TicketShadowPainter(
        clipper: clipper,
        shadow: shadow,
        shadowRadius: shadowRadius ?? ShadowRadius.zero,
      ),
      child: ClipPath(
        clipper: clipper,
        child: child),
    );
  }
}