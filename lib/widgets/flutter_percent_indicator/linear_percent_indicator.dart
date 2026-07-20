import 'package:flutter/material.dart';

@Deprecated('Use barRadius instead.')
enum LinearStrokeCap { butt, round, roundAll }

/// A linear progress indicator with optional animation, gradients, and labels.
///
/// [percent] must be between `0.0` and `1.0`.
class LinearPercentIndicator extends StatefulWidget {
  const LinearPercentIndicator({
    super.key,
    this.fillColor = Colors.transparent,
    this.percent = 0.0,
    this.lineHeight = 5.0,
    this.width,
    Color? backgroundColor,
    this.linearGradientBackgroundColor,
    this.linearGradient,
    Color? progressColor,
    this.animation = false,
    this.animationDuration = 500,
    this.animateFromLastPercent = false,
    this.animateToInitialPercent = true,
    this.isRTL = false,
    this.leading,
    this.trailing,
    this.center,
    this.addAutomaticKeepAlive = true,
    this.linearStrokeCap,
    this.barRadius,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0),
    this.alignment = MainAxisAlignment.start,
    this.maskFilter,
    this.clipLinearGradient = false,
    this.curve = Curves.linear,
    this.restartAnimation = false,
    this.onAnimationEnd,
    this.widgetIndicator,
    this.progressBorderColor,
    this.onPercentValue,
  })  : assert(percent >= 0.0 && percent <= 1.0),
        assert(
          linearGradient == null || progressColor == null,
          'Cannot provide both linearGradient and progressColor',
        ),
        assert(
          linearGradientBackgroundColor == null || backgroundColor == null,
          'Cannot provide both linearGradientBackgroundColor and backgroundColor',
        ),
        backgroundColor = backgroundColor ?? const Color(0xFFB8C7CB),
        progressColor = progressColor ?? Colors.red;

  final double percent;
  final double? width;
  final double lineHeight;
  final Color fillColor;
  final Color? progressBorderColor;
  final Color backgroundColor;
  final LinearGradient? linearGradientBackgroundColor;
  final Color progressColor;
  final bool animation;
  final int animationDuration;
  final Widget? leading;
  final Widget? trailing;
  final Widget? center;

  @Deprecated('Use barRadius instead.')
  final LinearStrokeCap? linearStrokeCap;

  final Radius? barRadius;
  final MainAxisAlignment alignment;
  final EdgeInsets padding;
  final bool animateFromLastPercent;
  final bool animateToInitialPercent;
  final LinearGradient? linearGradient;
  final bool addAutomaticKeepAlive;
  final bool isRTL;
  final MaskFilter? maskFilter;
  final bool clipLinearGradient;
  final Curve curve;
  final bool restartAnimation;
  final VoidCallback? onAnimationEnd;
  final Widget? widgetIndicator;
  final ValueChanged<double>? onPercentValue;

  @override
  State<LinearPercentIndicator> createState() => _LinearPercentIndicatorState();
}

class _LinearPercentIndicatorState extends State<LinearPercentIndicator>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  double _percent = 0.0;
  final _containerKey = GlobalKey();
  final _keyIndicator = GlobalKey();
  double _containerWidth = 0.0;
  double _containerHeight = 0.0;
  double _indicatorWidth = 0.0;
  double _indicatorHeight = 0.0;

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _containerWidth = _containerKey.currentContext?.size?.width ?? 0.0;
        _containerHeight = _containerKey.currentContext?.size?.height ?? 0.0;
        if (_keyIndicator.currentContext != null) {
          _indicatorWidth = _keyIndicator.currentContext?.size?.width ?? 0.0;
          _indicatorHeight = _keyIndicator.currentContext?.size?.height ?? 0.0;
        }
      });
    });

    if (widget.animation) {
      if (!widget.animateToInitialPercent) _percent = widget.percent;
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration),
      );
      _animation = Tween<double>(begin: _percent, end: widget.percent).animate(
        CurvedAnimation(parent: _animationController!, curve: widget.curve),
      )..addListener(() {
          setState(() {
            _percent = _animation!.value;
            widget.onPercentValue?.call(_percent);
          });
          if (widget.restartAnimation && _percent == 1.0) {
            _animationController!.repeat(min: 0, max: 1.0);
          }
        });
      _animationController!.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onAnimationEnd?.call();
        }
      });
      _animationController!.forward();
    } else {
      _percent = widget.percent;
    }
  }

  @override
  void didUpdateWidget(LinearPercentIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percent != widget.percent) {
      if (_animationController != null) {
        _animationController!.duration =
            Duration(milliseconds: widget.animationDuration);
        _animation = Tween<double>(
          begin: widget.animateFromLastPercent ? oldWidget.percent : 0.0,
          end: widget.percent,
        ).animate(
          CurvedAnimation(parent: _animationController!, curve: widget.curve),
        );
        _animationController!.forward(from: 0.0);
      } else {
        setState(() => _percent = widget.percent);
      }
    }
    if (oldWidget.animation &&
        !widget.animation &&
        _animationController != null) {
      _animationController!.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final items = <Widget>[];
    if (widget.leading != null) items.add(widget.leading!);

    final hasSetWidth = widget.width != null;
    final percentPositionedHorizontal =
        _containerWidth * _percent - _indicatorWidth / 3;

    final containerWidget = LayoutBuilder(
      builder: (context, constraints) {
        _containerWidth = constraints.maxWidth;
        _containerHeight = constraints.maxHeight;
        return Container(
          width: hasSetWidth ? widget.width : double.infinity,
          height: widget.lineHeight,
          padding: widget.padding,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CustomPaint(
                key: _containerKey,
                painter: _LinearPainter(
                  isRTL: widget.isRTL,
                  progress: _percent,
                  progressColor: widget.progressColor,
                  progressBorderColor: widget.progressBorderColor,
                  linearGradient: widget.linearGradient,
                  backgroundColor: widget.backgroundColor,
                  barRadius: widget.barRadius ?? Radius.zero,
                  linearGradientBackgroundColor:
                      widget.linearGradientBackgroundColor,
                  maskFilter: widget.maskFilter,
                  clipLinearGradient: widget.clipLinearGradient,
                ),
                child: widget.center != null
                    ? Center(child: widget.center)
                    : const SizedBox.shrink(),
              ),
              if (widget.widgetIndicator != null && _indicatorWidth == 0)
                Opacity(
                  opacity: 0.0,
                  key: _keyIndicator,
                  child: widget.widgetIndicator,
                ),
              if (widget.widgetIndicator != null &&
                  _containerWidth > 0 &&
                  _indicatorWidth > 0)
                Positioned(
                  right: widget.isRTL ? percentPositionedHorizontal : null,
                  left: !widget.isRTL ? percentPositionedHorizontal : null,
                  top: _containerHeight / 2 - _indicatorHeight,
                  child: widget.widgetIndicator!,
                ),
            ],
          ),
        );
      },
    );

    if (hasSetWidth) {
      items.add(containerWidget);
    } else {
      items.add(Expanded(child: containerWidget));
    }
    if (widget.trailing != null) items.add(widget.trailing!);

    return Material(
      color: Colors.transparent,
      child: ColoredBox(
        color: widget.fillColor,
        child: Row(
          mainAxisAlignment: widget.alignment,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.addAutomaticKeepAlive;
}

class _LinearPainter extends CustomPainter {
  _LinearPainter({
    required this.progress,
    required this.isRTL,
    required this.progressColor,
    required this.backgroundColor,
    required this.barRadius,
    this.progressBorderColor,
    this.linearGradient,
    this.maskFilter,
    required this.clipLinearGradient,
    this.linearGradientBackgroundColor,
  }) {
    _paintBackground.color = backgroundColor;
    _paintLine.color =
        progress == 0 ? progressColor.withValues(alpha: 0.0) : progressColor;
    if (progressBorderColor != null) {
      _paintLineBorder.color = progress == 0
          ? progressBorderColor!.withValues(alpha: 0.0)
          : progressBorderColor!;
    }
  }

  final Paint _paintBackground = Paint();
  final Paint _paintLine = Paint();
  final Paint _paintLineBorder = Paint();
  final double progress;
  final bool isRTL;
  final Color progressColor;
  final Color? progressBorderColor;
  final Color backgroundColor;
  final Radius barRadius;
  final LinearGradient? linearGradient;
  final LinearGradient? linearGradientBackgroundColor;
  final MaskFilter? maskFilter;
  final bool clipLinearGradient;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          barRadius,
        ),
      );
    canvas.drawPath(backgroundPath, _paintBackground);
    canvas.clipPath(backgroundPath);

    if (maskFilter != null) {
      _paintLineBorder.maskFilter = maskFilter;
      _paintLine.maskFilter = maskFilter;
    }

    if (linearGradientBackgroundColor != null) {
      final shaderEndPoint =
          clipLinearGradient ? Offset.zero : Offset(size.width, size.height);
      _paintBackground.shader = linearGradientBackgroundColor
          ?.createShader(Rect.fromPoints(Offset.zero, shaderEndPoint));
    }

    final xProgress = size.width * progress;
    final linePath = Path();
    final linePathBorder = Path();
    final factor = progressBorderColor != null ? 2.0 : 0.0;
    final correction = factor * 2;

    if (isRTL) {
      if (linearGradient != null) {
        final shader = _createGradientShaderRightToLeft(size, xProgress);
        _paintLineBorder.shader = shader;
        _paintLine.shader = shader;
      }
      linePath.addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width - size.width * progress,
            0,
            xProgress,
            size.height,
          ),
          barRadius,
        ),
      );
    } else {
      if (linearGradient != null) {
        final shader = _createGradientShaderLeftToRight(size, xProgress);
        _paintLineBorder.shader = shader;
        _paintLine.shader = shader;
      }
      if (progressBorderColor != null) {
        linePathBorder.addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, xProgress, size.height),
            barRadius,
          ),
        );
      }
      linePath.addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            factor,
            factor,
            xProgress - correction,
            size.height - correction,
          ),
          barRadius,
        ),
      );
    }

    if (progressBorderColor != null) {
      canvas.drawPath(linePathBorder, _paintLineBorder);
    }
    canvas.drawPath(linePath, _paintLine);
  }

  Shader _createGradientShaderRightToLeft(Size size, double xProgress) {
    final shaderEndPoint =
        clipLinearGradient ? Offset.zero : Offset(xProgress, size.height);
    return linearGradient!.createShader(
      Rect.fromPoints(Offset(size.width, size.height), shaderEndPoint),
    );
  }

  Shader _createGradientShaderLeftToRight(Size size, double xProgress) {
    final shaderEndPoint = clipLinearGradient
        ? Offset(size.width, size.height)
        : Offset(xProgress, size.height);
    return linearGradient!.createShader(
      Rect.fromPoints(Offset.zero, shaderEndPoint),
    );
  }

  @override
  bool shouldRepaint(covariant _LinearPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.isRTL != isRTL;
  }
}
