import 'package:flutter/material.dart';

/// A colored segment for [MultiSegmentLinearIndicator].
class SegmentLinearIndicator {
  const SegmentLinearIndicator({
    required this.percent,
    required this.color,
    this.enableStripes = false,
  });

  final double percent;
  final Color color;
  final bool enableStripes;
}

/// A multi-segment linear progress bar.
///
/// The sum of all [segments] percents must be `<= 1.0`.
class MultiSegmentLinearIndicator extends StatefulWidget {
  MultiSegmentLinearIndicator({
    super.key,
    required this.segments,
    this.lineHeight = 5.0,
    this.width,
    this.barRadius,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0),
    this.animation = false,
    this.animationDuration = 500,
    this.curve = Curves.linear,
    this.animateFromLastPercent = false,
    this.onAnimationEnd,
  }) {
    final sum = segments.fold<double>(
      0.0,
      (sum, segment) => sum + segment.percent,
    );
    assert(
      sum <= 1.0,
      'The sum of all segment percentages must be <= 1.0, but got $sum',
    );
  }

  final List<SegmentLinearIndicator> segments;
  final double lineHeight;
  final double? width;
  final Radius? barRadius;
  final EdgeInsets padding;
  final bool animation;
  final int animationDuration;
  final Curve curve;
  final bool animateFromLastPercent;
  final VoidCallback? onAnimationEnd;

  @override
  State<MultiSegmentLinearIndicator> createState() =>
      _MultiSegmentLinearIndicatorState();
}

class _MultiSegmentLinearIndicatorState
    extends State<MultiSegmentLinearIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  late List<Animation<double>> _segmentAnimations;
  late List<double> _segmentPercents;

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _segmentPercents = List.filled(widget.segments.length, 0.0);

    if (!widget.animation) {
      for (var i = 0; i < widget.segments.length; i++) {
        _segmentPercents[i] = widget.segments[i].percent;
      }
      return;
    }

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
    );
    _setupAnimations();
    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationEnd?.call();
      }
    });
    _animationController!.forward();
  }

  void _setupAnimations() {
    _segmentAnimations = List.generate(widget.segments.length, (index) {
      final start =
          widget.animateFromLastPercent ? _segmentPercents[index] : 0.0;
      return Tween<double>(
        begin: start,
        end: widget.segments[index].percent,
      ).animate(
        CurvedAnimation(parent: _animationController!, curve: widget.curve),
      )..addListener(() {
          setState(() {
            _segmentPercents[index] = _segmentAnimations[index].value;
          });
        });
    });
  }

  @override
  void didUpdateWidget(MultiSegmentLinearIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.animation &&
        !_areSegmentsEqual(oldWidget.segments, widget.segments)) {
      if (_segmentPercents.length != widget.segments.length) {
        _segmentPercents = List.filled(widget.segments.length, 0.0);
      }
      _animationController!.duration =
          Duration(milliseconds: widget.animationDuration);
      _setupAnimations();
      _animationController!.forward(from: 0.0);
    } else if (!widget.animation) {
      if (_segmentPercents.length != widget.segments.length) {
        _segmentPercents = List.filled(widget.segments.length, 0.0);
      }
      for (var i = 0; i < widget.segments.length; i++) {
        _segmentPercents[i] = widget.segments[i].percent;
      }
    }

    if (oldWidget.animation &&
        !widget.animation &&
        _animationController != null) {
      _animationController!.stop();
    }
  }

  bool _areSegmentsEqual(
    List<SegmentLinearIndicator> a,
    List<SegmentLinearIndicator> b,
  ) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].percent != b[i].percent || a[i].color != b[i].color) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: widget.padding,
      child: CustomPaint(
        painter: _MultiSegmentPainter(
          segments: widget.segments,
          segmentPercents: _segmentPercents,
          barRadius: widget.barRadius ?? Radius.zero,
        ),
        child: SizedBox(height: widget.lineHeight),
      ),
    );
  }
}

class _MultiSegmentPainter extends CustomPainter {
  _MultiSegmentPainter({
    required this.segments,
    required this.segmentPercents,
    required this.barRadius,
  });

  final List<SegmentLinearIndicator> segments;
  final List<double> segmentPercents;
  final Radius barRadius;

  @override
  void paint(Canvas canvas, Size size) {
    var startX = 0.0;

    for (var i = 0; i < segments.length; i++) {
      final segmentWidth = size.width * segmentPercents[i];
      final segmentPaint = Paint()
        ..color = segments[i].color
        ..style = PaintingStyle.fill;

      final segmentPath = Path();
      final rect = Rect.fromLTWH(startX, 0, segmentWidth, size.height);

      if (i == 0 && segmentPercents[i] == 1.0) {
        segmentPath.addRRect(RRect.fromRectAndRadius(rect, barRadius));
      } else if (i == 0) {
        segmentPath.addRRect(
          RRect.fromRectAndCorners(
            rect,
            topLeft: barRadius,
            bottomLeft: barRadius,
          ),
        );
      } else if (i == segments.length - 1) {
        segmentPath.addRRect(
          RRect.fromRectAndCorners(
            rect,
            topRight: barRadius,
            bottomRight: barRadius,
          ),
        );
      } else {
        segmentPath.addRect(rect);
      }

      canvas.drawPath(segmentPath, segmentPaint);

      if (segments[i].enableStripes) {
        _drawStripes(canvas, startX, segmentWidth, size.height);
      }

      startX += segmentWidth;
    }
  }

  void _drawStripes(Canvas canvas, double startX, double width, double height) {
    final stripePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    const stripeSpacing = 8.0;

    canvas.save();
    canvas.clipRect(Rect.fromLTWH(startX, 0, width, height));

    for (var x = startX - height;
        x < startX + width + height;
        x += stripeSpacing) {
      canvas.drawLine(Offset(x, height), Offset(x + height, 0), stripePaint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _MultiSegmentPainter oldDelegate) {
    return oldDelegate.segmentPercents != segmentPercents ||
        oldDelegate.segments != segments ||
        oldDelegate.barRadius != barRadius;
  }
}
