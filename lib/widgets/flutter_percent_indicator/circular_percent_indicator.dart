import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/utils/flutter_helper_utils.dart';

/// Arc drawing modes for [CircularPercentIndicator].
enum ArcType {
  half,
  full,
  fullReversed,
}

/// Stroke caps for the circular progress stroke.
enum CircularStrokeCap {
  butt,
  round,
  square,
}

extension CircularStrokeCapExtension on CircularStrokeCap {
  StrokeCap get strokeCap {
    switch (this) {
      case CircularStrokeCap.butt:
        return StrokeCap.butt;
      case CircularStrokeCap.round:
        return StrokeCap.round;
      case CircularStrokeCap.square:
        return StrokeCap.square;
    }
  }
}

/// A circular progress indicator with optional animation, gradients, and arcs.
///
/// [percent] must be between `0.0` and `1.0`.
class CircularPercentIndicator extends StatefulWidget {
  const CircularPercentIndicator({
    super.key,
    this.percent = 0.0,
    this.lineWidth = 5.0,
    this.startAngle = 0.0,
    required this.radius,
    this.fillColor = Colors.transparent,
    this.backgroundColor = const Color(0xFFB8C7CB),
    Color? progressColor,
    this.backgroundWidth = -1,
    this.linearGradient,
    this.animation = false,
    this.animationDuration = 500,
    this.header,
    this.footer,
    this.center,
    this.addAutomaticKeepAlive = true,
    this.circularStrokeCap = CircularStrokeCap.butt,
    this.arcBackgroundColor,
    this.arcType,
    this.animateFromLastPercent = false,
    this.animateToInitialPercent = true,
    this.reverse = false,
    this.curve = Curves.linear,
    this.maskFilter,
    this.restartAnimation = false,
    this.onAnimationEnd,
    this.widgetIndicator,
    this.rotateLinearGradient = false,
    this.clipRotatedLinearGradient = false,
    this.progressBorderColor,
    this.onPercentValue,
  })  : assert(startAngle >= 0.0),
        assert(percent >= 0.0 && percent <= 1.0),
        assert(
          linearGradient == null || progressColor == null,
          'Cannot provide both linearGradient and progressColor',
        ),
        assert(
          arcType != null || arcBackgroundColor == null,
          'arcType is required when arcBackgroundColor is set',
        ),
        progressColor = progressColor ?? Colors.red;

  /// Percent value between 0.0 and 1.0.
  final double percent;

  final double radius;

  /// Width of the progress stroke.
  final double lineWidth;

  /// Width of the unfilled background stroke. Negative = use [lineWidth].
  final double backgroundWidth;

  final Color fillColor;
  final Color? progressBorderColor;
  final Color backgroundColor;
  final Color progressColor;
  final bool animation;
  final int animationDuration;
  final Widget? header;
  final Widget? footer;
  final Widget? center;
  final LinearGradient? linearGradient;
  final CircularStrokeCap circularStrokeCap;

  /// Start angle in degrees.
  final double startAngle;
  final bool animateFromLastPercent;
  final bool animateToInitialPercent;
  final bool addAutomaticKeepAlive;
  final ArcType? arcType;
  final Color? arcBackgroundColor;
  final bool reverse;
  final MaskFilter? maskFilter;
  final Curve curve;
  final bool restartAnimation;
  final VoidCallback? onAnimationEnd;
  final Widget? widgetIndicator;
  final bool rotateLinearGradient;
  final bool clipRotatedLinearGradient;
  final ValueChanged<double>? onPercentValue;

  @override
  State<CircularPercentIndicator> createState() =>
      _CircularPercentIndicatorState();
}

class _CircularPercentIndicatorState extends State<CircularPercentIndicator>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  double _percent = 0.0;
  double _diameter = 0.0;

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
    _diameter = widget.radius * 2;
  }

  @override
  void didUpdateWidget(CircularPercentIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.radius != widget.radius) {
      _diameter = widget.radius * 2;
    }

    if (oldWidget.percent != widget.percent ||
        oldWidget.startAngle != widget.startAngle) {
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
    final items = <Widget>[
      if (widget.header != null) widget.header!,
      SizedBox(
        height: _diameter,
        width: _diameter,
        child: Stack(
          children: [
            CustomPaint(
              painter: _CirclePainter(
                progress: _percent * 360,
                progressColor: widget.progressColor,
                progressBorderColor: widget.progressBorderColor,
                backgroundColor: widget.backgroundColor,
                startAngle: widget.startAngle,
                circularStrokeCap: widget.circularStrokeCap,
                radius: widget.radius - widget.lineWidth / 2,
                lineWidth: widget.lineWidth,
                backgroundWidth: widget.backgroundWidth >= 0.0
                    ? widget.backgroundWidth
                    : widget.lineWidth,
                arcBackgroundColor: widget.arcBackgroundColor,
                arcType: widget.arcType,
                reverse: widget.reverse,
                linearGradient: widget.linearGradient,
                maskFilter: widget.maskFilter,
                rotateLinearGradient: widget.rotateLinearGradient,
                clipRotatedLinearGradient: widget.clipRotatedLinearGradient,
              ),
              child: widget.center != null
                  ? Center(child: widget.center)
                  : const SizedBox.expand(),
            ),
            if (widget.widgetIndicator != null && widget.animation)
              Positioned.fill(
                child: Transform.rotate(
                  angle: degreeToRadian(
                    (widget.circularStrokeCap != CircularStrokeCap.butt &&
                            widget.reverse)
                        ? -15
                        : 0,
                  ),
                  child: Transform.rotate(
                    angle: _indicatorAngle(_percent),
                    child: Transform.translate(
                      offset: Offset(
                        (widget.circularStrokeCap != CircularStrokeCap.butt)
                            ? widget.lineWidth / 2
                            : 0,
                        (-widget.radius + widget.lineWidth / 2),
                      ),
                      child: widget.widgetIndicator,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      if (widget.footer != null) widget.footer!,
    ];

    return Material(
      color: widget.fillColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: items,
      ),
    );
  }

  double _indicatorAngle(double percent) {
    if (widget.arcType != null) {
      final angle = _arcAngles(widget.arcType!).fixedStartAngle;
      final fixedPercent =
          widget.percent > 0 ? 1.0 / widget.percent * percent : 0.0;
      final margin = widget.arcType == ArcType.half
          ? 180 * widget.percent
          : 280 * widget.percent;
      return degreeToRadian(angle + margin * fixedPercent);
    }
    const angle = 360.0;
    return degreeToRadian((widget.reverse ? -angle : angle) * percent);
  }

  @override
  bool get wantKeepAlive => widget.addAutomaticKeepAlive;
}

_ArcAngles _arcAngles(ArcType arcType) {
  switch (arcType) {
    case ArcType.fullReversed:
      return const _ArcAngles(
        fixedStartAngle: 399,
        startAngleFixedMargin: 312 / 399,
      );
    case ArcType.full:
      return const _ArcAngles(
        fixedStartAngle: 220,
        startAngleFixedMargin: 172 / 220,
      );
    case ArcType.half:
      return const _ArcAngles(
        fixedStartAngle: 270,
        startAngleFixedMargin: 135 / 270,
      );
  }
}

class _ArcAngles {
  const _ArcAngles({
    required this.fixedStartAngle,
    required this.startAngleFixedMargin,
  });

  final double fixedStartAngle;
  final double startAngleFixedMargin;
}

class _CirclePainter extends CustomPainter {
  _CirclePainter({
    required this.lineWidth,
    required this.backgroundWidth,
    required this.progress,
    required this.radius,
    required this.progressColor,
    required this.backgroundColor,
    this.progressBorderColor,
    this.startAngle = 0.0,
    this.circularStrokeCap = CircularStrokeCap.butt,
    this.linearGradient,
    required this.reverse,
    this.arcBackgroundColor,
    this.arcType,
    this.maskFilter,
    required this.rotateLinearGradient,
    required this.clipRotatedLinearGradient,
  }) {
    _paintBackground
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = backgroundWidth
      ..strokeCap = circularStrokeCap.strokeCap;

    if (arcBackgroundColor != null) {
      _paintBackgroundStartAngle
        ..color = arcBackgroundColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth
        ..strokeCap = circularStrokeCap.strokeCap;
    }

    _paintLine
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = progressBorderColor != null ? lineWidth - 2 : lineWidth
      ..strokeCap = circularStrokeCap.strokeCap;

    if (progressBorderColor != null) {
      _paintLineBorder
        ..color = progressBorderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth
        ..strokeCap = circularStrokeCap.strokeCap;
    }
  }

  final Paint _paintBackground = Paint();
  final Paint _paintLine = Paint();
  final Paint _paintLineBorder = Paint();
  final Paint _paintBackgroundStartAngle = Paint();
  final double lineWidth;
  final double backgroundWidth;
  final double progress;
  final double radius;
  final Color progressColor;
  final Color? progressBorderColor;
  final Color backgroundColor;
  final CircularStrokeCap circularStrokeCap;
  final double startAngle;
  final LinearGradient? linearGradient;
  final Color? arcBackgroundColor;
  final ArcType? arcType;
  final bool reverse;
  final MaskFilter? maskFilter;
  final bool rotateLinearGradient;
  final bool clipRotatedLinearGradient;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    var fixedStartAngle = startAngle;
    var startAngleFixedMargin = 1.0;

    if (arcType != null) {
      final arcAngles = _arcAngles(arcType!);
      fixedStartAngle = arcAngles.fixedStartAngle;
      startAngleFixedMargin = arcAngles.startAngleFixedMargin;
    }

    if (arcType == null) {
      canvas.drawCircle(center, radius, _paintBackground);
    }

    if (maskFilter != null) {
      _paintLineBorder.maskFilter = maskFilter;
      _paintLine.maskFilter = maskFilter;
    }

    if (linearGradient != null) {
      if (rotateLinearGradient && progress > 0) {
        var correction = 0.0;
        if (_paintLine.strokeCap != StrokeCap.butt) {
          correction = math.atan(_paintLine.strokeWidth / 2 / radius);
        }
        final shader = SweepGradient(
          transform: reverse
              ? GradientRotation(
                  degreeToRadian(-90 - progress + startAngle) - correction,
                )
              : GradientRotation(
                  degreeToRadian(-90.0 + startAngle) - correction,
                ),
          startAngle: 0,
          endAngle: clipRotatedLinearGradient
              ? degreeToRadian(360)
              : degreeToRadian(progress),
          tileMode: TileMode.clamp,
          colors: reverse
              ? linearGradient!.colors.reversed.toList()
              : linearGradient!.colors,
        ).createShader(Rect.fromCircle(center: center, radius: radius));
        _paintLineBorder.shader = shader;
        _paintLine.shader = shader;
      } else if (!rotateLinearGradient) {
        final shader = linearGradient!.createShader(
          Rect.fromCircle(center: center, radius: radius),
        );
        _paintLineBorder.shader = shader;
        _paintLine.shader = shader;
      }
    }

    if (arcBackgroundColor != null) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        degreeToRadian(-90.0 + fixedStartAngle),
        degreeToRadian(360 * startAngleFixedMargin),
        false,
        _paintBackgroundStartAngle,
      );
    }

    if (reverse) {
      final start = degreeToRadian(
        360 * startAngleFixedMargin - 90.0 + fixedStartAngle,
      );
      final end = degreeToRadian(-progress * startAngleFixedMargin);
      final rect = Rect.fromCircle(center: center, radius: radius);
      if (progressBorderColor != null) {
        canvas.drawArc(rect, start, end, false, _paintLineBorder);
      }
      canvas.drawArc(rect, start, end, false, _paintLine);
    } else {
      final start = degreeToRadian(-90.0 + fixedStartAngle);
      final end = degreeToRadian(progress * startAngleFixedMargin);
      final rect = Rect.fromCircle(center: center, radius: radius);
      if (progressBorderColor != null) {
        canvas.drawArc(rect, start, end, false, _paintLineBorder);
      }
      canvas.drawArc(rect, start, end, false, _paintLine);
    }
  }

  @override
  bool shouldRepaint(covariant _CirclePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.lineWidth != lineWidth ||
        oldDelegate.radius != radius ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.reverse != reverse;
  }
}
