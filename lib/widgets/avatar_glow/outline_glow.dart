import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OutlineAvatarGlow extends StatefulWidget {
  /// Creates a widget that displays a glowing outline around its child.
  ///
  /// The [child] parameter is required and must not be null.
  const OutlineAvatarGlow({
    super.key,
    required this.child,
    this.glowCount = 2,
    this.glowColor = Colors.white,
    this.glowShape = BoxShape.circle,
    this.glowBorderRadius,
    this.duration = const Duration(seconds: 2),
    this.startDelay,
    this.animate = true,
    this.repeat = true,
    this.curve = Curves.fastOutSlowIn,
    this.glowRadiusFactor = 0.7,
  });

  /// The child widget to display inside the glow.
  final Widget child;

  /// The number of glows to display.
  ///
  /// Defaults to 2.
  final int glowCount;

  /// The color of the glow effect.
  ///
  /// Defaults to [Colors.white].
  final Color glowColor;

  /// The shape of the glow effect.
  ///
  /// Defaults to [BoxShape.circle].
  final BoxShape glowShape;

  /// The border radius of the glow effect.
  ///
  /// If provided, it overrides the border radius of the [glowShape].
  final BorderRadius? glowBorderRadius;

  /// The duration of the glow animation.
  ///
  /// Defaults to 2 seconds.
  final Duration duration;

  /// The delay before starting the glow animation.
  ///
  /// Defaults to null (no delay).
  final Duration? startDelay;

  /// Whether to animate the glow effect.
  ///
  /// Defaults to true.
  final bool animate;

  /// Whether to repeat the glow animation.
  ///
  /// Defaults to true.
  final bool repeat;

  /// The curve used for the glow animation.
  ///
  /// Defaults to [Curves.fastOutSlowIn].
  final Curve curve;

  /// The factor to adjust the glow radius.
  ///
  /// This factor determines the distance of the glow from the child widget.
  ///
  /// Defaults to 0.7.
  final double glowRadiusFactor;

  @override
  State<OutlineAvatarGlow> createState() => _OutlineAvatarGlowState();
}

class _OutlineAvatarGlowState extends State<OutlineAvatarGlow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final _OutlineGlowPainter _painter;
  late final Tween<double> _opacityTween = Tween<double>(begin: 0.3, end: 0);

  void _startAnimation() async {
    final startDelay = widget.startDelay;
    if (startDelay != null) {
      await Future.delayed(startDelay);
    }

    if (mounted) {
      if (widget.repeat) {
        _controller.repeat();
      } else {
        _controller.forward();
      }
    }
  }

  void _stopAnimation() {
    _controller.reverse().then((_) {
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
        _OutlineGlowPainter(progress: _controller, glowColor: widget.glowColor);

    if (widget.animate) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(OutlineAvatarGlow oldWidget) {
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
    return RepaintBoundary(
      child: CustomPaint(
        painter: _painter
          ..curve = widget.curve
          ..opacityTween = _opacityTween
          ..glowCount = widget.glowCount
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

class _OutlineGlowPainter extends ChangeNotifier implements CustomPainter {
  _OutlineGlowPainter({required this.progress, required this.glowColor}) {
    progress.addListener(notifyListeners);
  }

  final Animation<double> progress;
  final Color glowColor;

  Curve? _curve;
  Tween<double>? _opacityTween;
  int? _glowCount;
  BoxDecoration? _glowDecoration;
  double? _glowRadiusFactor;

  Curve get curve => _curve!;
  set curve(Curve value) {
    if (_curve != value) {
      _curve = value;
      notifyListeners();
    }
  }

  Tween<double> get opacityTween => _opacityTween!;
  set opacityTween(Tween<double> value) {
    if (_opacityTween != value) {
      _opacityTween = value;
      notifyListeners();
    }
  }

  int get glowCount => _glowCount!;
  set glowCount(int value) {
    if (_glowCount != value) {
      _glowCount = value;
      notifyListeners();
    }
  }

  BoxDecoration get glowDecoration => _glowDecoration!;
  set glowDecoration(BoxDecoration value) {
    if (_glowDecoration != value) {
      _glowDecoration = value;
      notifyListeners();
    }
  }

  double get glowRadiusFactor => _glowRadiusFactor!;
  set glowRadiusFactor(double value) {
    if (_glowRadiusFactor != value) {
      _glowRadiusFactor = value;
      notifyListeners();
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final opacity = _opacityTween!.evaluate(progress);

    final paint = Paint()
      ..color = glowColor.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth =
          4.0; // Adjust this value to change the thickness of the line

    final glowSize = math.min(size.width, size.height);
    final glowRadius = glowSize / 2;

    final currentProgress = curve.transform(progress.value);

    for (int i = 1; i <= glowCount; i++) {
      final currentRadius =
          glowRadius + glowRadius * glowRadiusFactor * i * currentProgress;

      canvas.drawCircle(size.center(Offset.zero), currentRadius, paint);
    }
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
