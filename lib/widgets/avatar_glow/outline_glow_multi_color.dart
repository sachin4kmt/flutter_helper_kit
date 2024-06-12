part of flutter_helper_kit;


class OutlineAvatarGlowMultiColor extends StatefulWidget {
  /// Creates a widget that provides a glowing effect with multiple colors around a child widget's outline.
  ///
  /// The `child` parameter specifies the widget around which the glow effect will be applied.
  /// The `glowColors` parameter specifies the list of colors to use for the glow effect.
  /// The `glowShape` parameter specifies the shape of the glow effect, which defaults to a circle.
  /// The `glowBorderRadius` parameter specifies the border radius for the glow effect.
  /// The `duration` parameter specifies the duration of the animation.
  /// The `startDelay` parameter specifies the delay before starting the animation.
  /// The `animate` parameter specifies whether to animate the glow effect.
  /// The `repeat` parameter specifies whether to repeat the animation.
  /// The `curve` parameter specifies the animation curve.
  /// The `glowRadiusFactor` parameter specifies the factor to control the size of the glow effect.
  const OutlineAvatarGlowMultiColor({
    Key? key,
    required this.child,
    required this.glowColors,
    this.glowShape = BoxShape.circle,
    this.glowBorderRadius,
    this.duration = const Duration(seconds: 2),
    this.startDelay,
    this.animate = true,
    this.repeat = true,
    this.curve = Curves.fastOutSlowIn,
    this.glowRadiusFactor = 0.7,
  }) : super(key: key);

  /// Whether to animate the glow effect.
  final bool animate;

  /// The widget around which the glow effect will be applied.
  final Widget child;

  /// The animation curve.
  final Curve curve;

  /// The duration of the animation.
  final Duration duration;

  /// The border radius for the glow effect.
  final BorderRadius? glowBorderRadius;

  /// The list of colors to use for the glow effect.
  final List<Color> glowColors;

  /// The factor to control the size of the glow effect.
  final double glowRadiusFactor;

  /// The shape of the glow effect.
  final BoxShape glowShape;

  /// Whether to repeat the animation.
  final bool repeat;

  /// The delay before starting the animation.
  final Duration? startDelay;

  @override
  State<OutlineAvatarGlowMultiColor> createState() => _OutlineAvatarGlowMultiColorState();
}

class _OutlineAvatarGlowMultiColorState extends State<OutlineAvatarGlowMultiColor> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Tween<double> _opacityTween = Tween<double>(begin: 0.3, end: 0);
  late final _OutlineMultiGlowPainter _painter;

  @override
  void didUpdateWidget(OutlineAvatarGlowMultiColor oldWidget) {
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
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _painter = _OutlineMultiGlowPainter(progress: _controller);

    if (widget.animate) {
      _startAnimation();
    }
  }

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
  Widget build(BuildContext context) {
    if(widget.glowColors.isEmpty){
      return widget.child;
    }
    return RepaintBoundary(
      child: CustomPaint(
        painter: _painter
          ..curve = widget.curve
          ..opacityTween = _opacityTween
          ..glowCount = widget.glowColors.length
          ..glowDecoration = BoxDecoration(
            color: Colors.transparent,
            shape: widget.glowShape,
            borderRadius: widget.glowBorderRadius,
          )
          ..glowRadiusFactor = widget.glowRadiusFactor
          ..glowColors = widget.glowColors, // Pass the glow colors to the painter
        child: widget.child,
      ),
    );
  }
}

class _OutlineMultiGlowPainter extends ChangeNotifier implements CustomPainter {
  _OutlineMultiGlowPainter({required this.progress}) {
    progress.addListener(notifyListeners);
  }

  final Animation<double> progress;

  Curve? _curve;
  List<Color>? _glowColors; // List of glow colors
  int? _glowCount;
  BoxDecoration? _glowDecoration;
  final Path _glowPath = Path();
  double? _glowRadiusFactor;
  Tween<double>? _opacityTween;

  @override
  void dispose() {
    progress.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  bool? hitTest(Offset position) => null;

  @override
  void paint(Canvas canvas, Size size) {
    // final opacity = opacityTween.evaluate(progress);

    final glowSize = math.min(size.width, size.height);
    final glowRadius = glowSize / 2;

    final currentProgress = curve.transform(progress.value);

    _glowPath.reset();

    for (int i = 1; i <= glowCount; i++) {
      final currentRadius = glowRadius + glowRadius * glowRadiusFactor * i * currentProgress;

      // final currentRect = Rect.fromCircle(
      //   center: size.center(Offset.zero),
      //   radius: currentRadius,
      // );

      final paint = Paint()
        ..color = glowColors[i % glowColors.length] // Use modulo to cycle through colors
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0; // Adjust this value to change the thickness of the line

      canvas.drawCircle(size.center(Offset.zero), currentRadius, paint);
    }
  }

  @override
  SemanticsBuilderCallback? get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  String toString() => describeIdentity(this);

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

  List<Color> get glowColors => _glowColors!;

  set glowColors(List<Color> value) {
    if (_glowColors != value) {
      _glowColors = value;
      notifyListeners();
    }
  }
}
