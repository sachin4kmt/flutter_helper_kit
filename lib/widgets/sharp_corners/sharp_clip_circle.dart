import 'package:flutter/material.dart';

class SharpClipCircle extends StatelessWidget {
  const SharpClipCircle({
    super.key,
    required this.child,
    this.clipBehavior = Clip.antiAlias,
  });

  final Clip clipBehavior;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipBehavior: clipBehavior,
      clipper: CircleClipper(),
      child: child,
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    return path;
  }

  @override
  bool shouldReclip(CircleClipper oldClipper) => false;
}
