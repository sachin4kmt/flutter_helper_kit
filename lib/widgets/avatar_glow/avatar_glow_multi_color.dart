import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_helper_kit/flutter_helper_kit.dart';

/// A widget that adds a glowing effect around with multipale colors its child.
class AvatarGlowMultiColor extends StatefulWidget {
  /// Creates an [AvatarGlowMultiColor] widget.
  const AvatarGlowMultiColor({
    super.key,
    required this.child,
    this.glowColors = const [Colors.white],
    this.glowShape = BoxShape.circle,
    this.glowBorderRadius,
    this.duration = const Duration(seconds: 2),
    this.startDelay,
    this.animate = true,
    this.repeat = true,
    this.curve = Curves.fastOutSlowIn,
    this.glowRadiusFactor = 0.7,
  }) : assert(
          glowShape != BoxShape.circle || glowBorderRadius == null,
          'Cannot specify a border radius if the shape is a circle.',
        );

  /// The child widget to display inside the glowing effect.
  final Widget child;

  /// The list of colors for the glow effects.
  final List<Color> glowColors;

  /// The shape of the glow effect.
  final BoxShape glowShape;

  /// The border radius for the glow effect.
  final BorderRadius? glowBorderRadius;

  /// The duration of the glowing animation.
  final Duration duration;

  /// The delay before starting the glowing animation.
  final Duration? startDelay;

  /// Whether to animate the glowing effect.
  final bool animate;

  /// Whether to repeat the glowing animation.
  final bool repeat;

  /// The curve for the glowing animation.
  final Curve curve;

  /// The factor that determines the size of each glow effect relative to the original size.
  final double glowRadiusFactor;

  @override
  State<AvatarGlowMultiColor> createState() => _AvatarGlowMultiColorState();
}

class _AvatarGlowMultiColorState extends State<AvatarGlowMultiColor>
    with SingleTickerProviderStateMixin<AvatarGlowMultiColor> {
  late final AnimationController _controller;
  late final _GlowMultiPainter _painter;
  late final List<Tween<double>> _opacityTweens;

  void _startAnimation() async {
    final startDelay = widget.startDelay;
    if (startDelay != null) {
      await Future.delayed(startDelay);
    }

    // Check if the widget is still mounted before starting the animation.
    if (mounted) {
      if (widget.repeat) {
        _controller.repeat();
      } else {
        _controller.forward();
      }
    }
  }

  void _stopAnimation() {
    // Wait for the animation to finish before stopping it.
    _controller.reverse().then((_) {
      // Check if the widget is still mounted before stopping the animation.
      if (mounted) {
        _controller.stop();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _painter =
        _GlowMultiPainter(progress: _controller, glowColors: widget.glowColors);
    _opacityTweens = List.generate(widget.glowColors.length, (index) {
      return Tween<double>(begin: 0.3, end: 0);
    });

    if (widget.animate) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(covariant AvatarGlowMultiColor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _startAnimation();
      } else {
        _stopAnimation();
      }
    }

    if (widget.repeat != oldWidget.repeat) {
      if (widget.repeat) {
        _controller.repeat();
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.glowColors.isEmpty) {
      return widget.child;
    }
    return RepaintBoundary(
      child: CustomPaint(
        painter: _painter
          ..curve = widget.curve
          ..opacityTweens = _opacityTweens
          ..glowDecoration = BoxDecoration(
            color: Colors.transparent,
            shape: widget.glowShape,
            borderRadius: widget.glowBorderRadius,
          )
          ..glowRadiusFactor = widget.glowRadiusFactor,
        child: widget.child,
      ),
    );
  }
}

class _GlowMultiPainter extends ChangeNotifier implements CustomPainter {
  _GlowMultiPainter({required this.progress, required this.glowColors}) {
    progress.addListener(notifyListeners);
  }

  final Animation<double> progress;
  final List<Color> glowColors;

  Curve get curve => _curve!;
  Curve? _curve;

  set curve(Curve value) {
    if (_curve != value) {
      _curve = value;
      notifyListeners();
    }
  }

  List<Tween<double>> get opacityTweens => _opacityTweens!;
  List<Tween<double>>? _opacityTweens;

  set opacityTweens(List<Tween<double>> value) {
    if (_opacityTweens != value) {
      _opacityTweens = value;
      notifyListeners();
    }
  }

  BoxDecoration get glowDecoration => _glowDecoration!;
  BoxDecoration? _glowDecoration;

  set glowDecoration(BoxDecoration value) {
    if (_glowDecoration != value) {
      _glowDecoration = value;
      notifyListeners();
    }
  }

  double get glowRadiusFactor => _glowRadiusFactor!;
  double? _glowRadiusFactor;

  set glowRadiusFactor(double value) {
    if (_glowRadiusFactor != value) {
      _glowRadiusFactor = value;
      notifyListeners();
    }
  }

  // We cache the path so that we don't have to recreate it
  // every time we paint.
  final Path _glowPath = Path();

  @override
  void paint(Canvas canvas, Size size) {
    final opacityList =
        opacityTweens.map((tween) => tween.evaluate(progress)).toList();

    final glowSize = math.min(size.width, size.height);
    final glowRadius = glowSize / 2;

    final currentProgress = curve.transform(progress.value);

    // Cache the path and reuse it for each glow.
    _glowPath.reset();

    // We need to draw the glows from the smallest to the largest.
    for (int i = 0; i < glowColors.length; i++) {
      final paint = Paint()
        ..color = glowColors[i].withColorOpacity(opacityList[i])
        ..style = PaintingStyle.fill;

      final currentRadius = glowRadius +
          glowRadius * glowRadiusFactor * (i + 1) * currentProgress;

      final currentRect = Rect.fromCircle(
        center: size.center(Offset.zero),
        radius: currentRadius,
      );

      _addGlowPath(currentRect);
      canvas.drawPath(_glowPath, paint);
    }
  }

  void _addGlowPath(Rect glowRect) {
    _glowPath.addPath(
      glowDecoration.getClipPath(
        glowRect,
        TextDirection.ltr,
      ),
      Offset.zero,
    );
  }

  @override
  void dispose() {
    progress.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  bool? hitTest(Offset position) => null;

  @override
  SemanticsBuilderCallback? get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

  @override
  String toString() => describeIdentity(this);
}
