import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A widget that takes a fixed amount of space in the direction of its parent.
///
/// It only works in the following cases:
/// - It is a descendant of a [Row], [Column], or [Flex],
/// and the path from the [Space] widget to its enclosing [Row], [Column], or
/// [Flex] must contain only [StatelessWidget]s or [StatefulWidget]s (not other
/// kinds of widgets, like [RenderObjectWidget]s).
/// - It is a descendant of a [Scrollable].
///
/// See also:
///
///  * [SpaceMax], a Space that can take, at most, the amount of space specified.
///  * [SpaceMin], a flexible Space with a minimum (and optional maximum) extent.
///  * [SliverSpace], the sliver version of this widget.
class Space extends StatelessWidget {
  /// Creates a widget that takes a fixed [mainAxisExtent] of space in the
  /// direction of its parent.
  ///
  /// The [mainAxisExtent] must not be null and must be positive.
  /// The [crossAxisExtent] must be either null or positive.
  const Space(
    this.mainAxisExtent, {
    super.key,
    this.crossAxisExtent,
    this.color,
  })  : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
        assert(crossAxisExtent == null || crossAxisExtent >= 0);

  /// Creates a widget that takes a fixed [mainAxisExtent] of space in the
  /// direction of its parent and expands in the cross axis direction.
  ///
  /// The [mainAxisExtent] must not be null and must be positive.
  const Space.expand(
    double mainAxisExtent, {
    Key? key,
    Color? color,
  }) : this(
          mainAxisExtent,
          key: key,
          crossAxisExtent: double.infinity,
          color: color,
        );

  /// The amount of space this widget takes in the direction of its parent.
  ///
  /// For example:
  /// - If the parent is a [Column] this is the height of this widget.
  /// - If the parent is a [Row] this is the width of this widget.
  ///
  /// Must not be null and must be positive.
  final double mainAxisExtent;

  /// The amount of space this widget takes in the opposite direction of the
  /// parent.
  ///
  /// For example:
  /// - If the parent is a [Column] this is the width of this widget.
  /// - If the parent is a [Row] this is the height of this widget.
  ///
  /// Must be positive or null. If it's null (the default) the cross axis extent
  /// will be the same as the constraints of the parent in the opposite
  /// direction.
  final double? crossAxisExtent;

  /// The color used to fill the Space.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scrollableState = Scrollable.maybeOf(context);
    final AxisDirection? axisDirection = scrollableState?.axisDirection;
    final Axis? fallbackDirection =
        axisDirection == null ? null : axisDirectionToAxis(axisDirection);

    return _RawSpace(
      mainAxisExtent,
      crossAxisExtent: crossAxisExtent,
      color: color,
      fallbackDirection: fallbackDirection,
    );
  }
}

/// A widget that takes, at most, an amount of space in a [Row], [Column],
/// or [Flex] widget.
///
/// A [SpaceMax] widget must be a descendant of a [Row], [Column], or [Flex],
/// and the path from the [SpaceMax] widget to its enclosing [Row], [Column], or
/// [Flex] must contain only [StatelessWidget]s or [StatefulWidget]s (not other
/// kinds of widgets, like [RenderObjectWidget]s).
///
/// See also:
///
///  * [Space], the unflexible version of this widget.
///  * [SpaceMin], a flexible Space with a minimum extent.
class SpaceMax extends StatelessWidget {
  /// Creates a widget that takes, at most, the specified [mainAxisExtent] of
  /// space in a [Row], [Column], or [Flex] widget.
  ///
  /// The [mainAxisExtent] must not be null and must be positive.
  /// The [crossAxisExtent] must be either null or positive.
  const SpaceMax(
    this.mainAxisExtent, {
    super.key,
    this.crossAxisExtent,
    this.color,
  })  : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
        assert(crossAxisExtent == null || crossAxisExtent >= 0);

  /// Creates a widget that takes, at most, the specified [mainAxisExtent] of
  /// space in a [Row], [Column], or [Flex] widget and expands in the cross axis
  /// direction.
  ///
  /// The [mainAxisExtent] must not be null and must be positive.
  /// The [crossAxisExtent] must be either null or positive.
  const SpaceMax.expand(
    double mainAxisExtent, {
    Key? key,
    Color? color,
  }) : this(
          mainAxisExtent,
          key: key,
          crossAxisExtent: double.infinity,
          color: color,
        );

  /// The amount of space this widget takes in the direction of the parent.
  ///
  /// If the parent is a [Column] this is the height of this widget.
  /// If the parent is a [Row] this is the width of this widget.
  ///
  /// Must not be null and must be positive.
  final double mainAxisExtent;

  /// The amount of space this widget takes in the opposite direction of the
  /// parent.
  ///
  /// If the parent is a [Column] this is the width of this widget.
  /// If the parent is a [Row] this is the height of this widget.
  ///
  /// Must be positive or null. If it's null (the default) the cross axis extent
  /// will be the same as the constraints of the parent in the opposite
  /// direction.
  final double? crossAxisExtent;

  /// The color used to fill the Space.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Axis? scrollAxis = _nearestScrollAxisBeforeFlex(context);
    if (scrollAxis != null) {
      return _RawSpace(
        mainAxisExtent,
        crossAxisExtent: crossAxisExtent,
        color: color,
        fallbackDirection: scrollAxis,
      );
    }

    return Flexible(
      child: _RawSpace(
        mainAxisExtent,
        crossAxisExtent: crossAxisExtent,
        color: color,
      ),
    );
  }
}

/// Deprecated alias for [SpaceMax].
@Deprecated('Use SpaceMax instead')
typedef MaxSpace = SpaceMax;

/// A flexible spacer with a minimum gap — optionally capped by [max].
///
/// Nothing is required. [maxExpend] defaults from whether [max] is set:
/// * [max] **not** set → [maxExpend] = `true` (expand like [Spacer], keep [min])
/// * [max] **set** → [maxExpend] = `false` (clamp to `[min, max]`)
///
/// Override [maxExpend] explicitly when needed (e.g. `max: 20, maxExpend: true`
/// keeps [min] but may grow beyond [max]).
///
/// ```dart
/// SpaceMin()                              // min 0, expand
/// SpaceMin(min: 10)                       // min 10, expand
/// SpaceMin(min: 10, max: 20)              // 10–20 (auto maxExpend: false)
/// SpaceMin(min: 10, max: 20, maxExpend: true)  // min 10, expand past 20
/// ```
///
/// Must be a descendant of a [Row], [Column], or [Flex].
/// In a [Scrollable], expansion is not finite, so the resolved extent is [max]
/// when capped, otherwise [min].
class SpaceMin extends StatelessWidget {
  /// Creates a flexible space with [min] (and optional [max]) extent.
  const SpaceMin({
    super.key,
    this.min = 0,
    this.max,
    bool? maxExpend,
    this.crossAxisExtent,
    this.color,
  })  : assert(min >= 0 && min < double.infinity),
        assert(max == null || (max >= min && max < double.infinity)),
        assert(crossAxisExtent == null || crossAxisExtent >= 0),
        maxExpend = maxExpend ?? (max == null);

  /// Minimum main-axis extent. Default is `0`.
  final double min;

  /// Optional maximum main-axis extent.
  ///
  /// When set, [maxExpend] defaults to `false` (range `[min, max]`).
  final double? max;

  /// Whether this space should expand to fill remaining free space.
  ///
  /// Defaults to `true` when [max] is null, otherwise `false`.
  final bool maxExpend;

  /// Optional cross-axis extent (same meaning as [Space.crossAxisExtent]).
  final double? crossAxisExtent;

  /// The color used to fill the space.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final double? effectiveMax = maxExpend ? null : (max ?? min);
    final Axis? scrollAxis = _nearestScrollAxisBeforeFlex(context);

    if (scrollAxis != null) {
      return _RawSpaceRange(
        minExtent: min,
        maxExtent: effectiveMax,
        crossAxisExtent: crossAxisExtent,
        color: color,
        fallbackDirection: scrollAxis,
      );
    }

    return Flexible(
      fit: maxExpend ? FlexFit.tight : FlexFit.loose,
      child: _RawSpaceRange(
        minExtent: min,
        maxExtent: effectiveMax,
        crossAxisExtent: crossAxisExtent,
        color: color,
      ),
    );
  }
}

/// Returns the scroll axis only when the nearest relevant parent is a
/// [Scrollable]. A nested [Row]/[Column] inside a scroll view still behaves as
/// a regular Flex and therefore returns `null`.
Axis? _nearestScrollAxisBeforeFlex(BuildContext context) {
  Axis? scrollAxis;
  context.visitAncestorElements((Element element) {
    final Widget widget = element.widget;
    if (widget is Flex) return false;
    if (widget is Scrollable) {
      scrollAxis = axisDirectionToAxis(widget.axisDirection);
      return false;
    }
    return true;
  });
  return scrollAxis;
}

class _RawSpace extends LeafRenderObjectWidget {
  const _RawSpace(
    this.mainAxisExtent, {
    this.crossAxisExtent,
    this.color,
    this.fallbackDirection,
  })  : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
        assert(crossAxisExtent == null || crossAxisExtent >= 0);

  final double mainAxisExtent;

  final double? crossAxisExtent;

  final Color? color;

  final Axis? fallbackDirection;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSpace(
      mainAxisExtent: mainAxisExtent,
      crossAxisExtent: crossAxisExtent ?? 0,
      color: color,
      fallbackDirection: fallbackDirection,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSpace renderObject) {
    renderObject
      ..mainAxisExtent = mainAxisExtent
      ..crossAxisExtent = crossAxisExtent ?? 0
      ..color = color
      ..fallbackDirection = fallbackDirection;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('mainAxisExtent', mainAxisExtent));
    properties.add(
        DoubleProperty('crossAxisExtent', crossAxisExtent, defaultValue: 0));
    properties.add(ColorProperty('color', color));
    properties.add(EnumProperty<Axis>('fallbackDirection', fallbackDirection));
  }
}

/// Flexible main-axis space clamped to `[minExtent, maxExtent]` (or unbounded
/// max when [maxExtent] is null).
class _RawSpaceRange extends LeafRenderObjectWidget {
  const _RawSpaceRange({
    required this.minExtent,
    required this.maxExtent,
    this.crossAxisExtent,
    this.color,
    this.fallbackDirection,
  });

  final double minExtent;
  final double? maxExtent;
  final double? crossAxisExtent;
  final Color? color;
  final Axis? fallbackDirection;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSpaceRange(
      minExtent: minExtent,
      maxExtent: maxExtent,
      crossAxisExtent: crossAxisExtent ?? 0,
      color: color,
      fallbackDirection: fallbackDirection,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderSpaceRange renderObject) {
    renderObject
      ..minExtent = minExtent
      ..maxExtent = maxExtent
      ..crossAxisExtent = crossAxisExtent ?? 0
      ..color = color
      ..fallbackDirection = fallbackDirection;
  }
}

class _RenderSpace extends RenderBox {
  _RenderSpace({
    required double mainAxisExtent,
    double? crossAxisExtent,
    Axis? fallbackDirection,
    Color? color,
  })  : _mainAxisExtent = mainAxisExtent,
        _crossAxisExtent = crossAxisExtent,
        _color = color,
        _fallbackDirection = fallbackDirection;

  double get mainAxisExtent => _mainAxisExtent;
  double _mainAxisExtent;
  set mainAxisExtent(double value) {
    if (_mainAxisExtent != value) {
      _mainAxisExtent = value;
      markNeedsLayout();
    }
  }

  double? get crossAxisExtent => _crossAxisExtent;
  double? _crossAxisExtent;
  set crossAxisExtent(double? value) {
    if (_crossAxisExtent != value) {
      _crossAxisExtent = value;
      markNeedsLayout();
    }
  }

  Axis? get fallbackDirection => _fallbackDirection;
  Axis? _fallbackDirection;
  set fallbackDirection(Axis? value) {
    if (_fallbackDirection != value) {
      _fallbackDirection = value;
      markNeedsLayout();
    }
  }

  Axis? get _direction {
    final parentNode = parent;
    if (parentNode is RenderFlex) {
      return parentNode.direction;
    } else {
      return fallbackDirection;
    }
  }

  Color? get color => _color;
  Color? _color;
  set color(Color? value) {
    if (_color != value) {
      _color = value;
      markNeedsPaint();
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _computeIntrinsicExtent(
      Axis.horizontal,
      () => super.computeMinIntrinsicWidth(height),
    )!;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _computeIntrinsicExtent(
      Axis.horizontal,
      () => super.computeMaxIntrinsicWidth(height),
    )!;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _computeIntrinsicExtent(
      Axis.vertical,
      () => super.computeMinIntrinsicHeight(width),
    )!;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _computeIntrinsicExtent(
      Axis.vertical,
      () => super.computeMaxIntrinsicHeight(width),
    )!;
  }

  double? _computeIntrinsicExtent(Axis axis, double Function() compute) {
    final Axis? direction = _direction;
    if (direction == axis) {
      return _mainAxisExtent;
    } else {
      if (_crossAxisExtent!.isFinite) {
        return _crossAxisExtent;
      } else {
        return compute();
      }
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final Axis? direction = _direction;

    if (direction != null) {
      if (direction == Axis.horizontal) {
        return constraints.constrain(Size(mainAxisExtent, crossAxisExtent!));
      } else {
        return constraints.constrain(Size(crossAxisExtent!, mainAxisExtent));
      }
    } else {
      throw FlutterError(
        'A Space widget must be placed directly inside a Flex widget '
        'or its fallbackDirection must not be null',
      );
    }
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (color != null) {
      final Paint paint = Paint()..color = color!;
      context.canvas.drawRect(offset & size, paint);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('mainAxisExtent', mainAxisExtent));
    properties.add(DoubleProperty('crossAxisExtent', crossAxisExtent));
    properties.add(ColorProperty('color', color));
    properties.add(EnumProperty<Axis>('fallbackDirection', fallbackDirection));
  }
}

class _RenderSpaceRange extends RenderBox {
  _RenderSpaceRange({
    required double minExtent,
    double? maxExtent,
    double? crossAxisExtent,
    Color? color,
    Axis? fallbackDirection,
  })  : _minExtent = minExtent,
        _maxExtent = maxExtent,
        _crossAxisExtent = crossAxisExtent,
        _color = color,
        _fallbackDirection = fallbackDirection;

  double get minExtent => _minExtent;
  double _minExtent;
  set minExtent(double value) {
    if (_minExtent != value) {
      _minExtent = value;
      markNeedsLayout();
    }
  }

  double? get maxExtent => _maxExtent;
  double? _maxExtent;
  set maxExtent(double? value) {
    if (_maxExtent != value) {
      _maxExtent = value;
      markNeedsLayout();
    }
  }

  double? get crossAxisExtent => _crossAxisExtent;
  double? _crossAxisExtent;
  set crossAxisExtent(double? value) {
    if (_crossAxisExtent != value) {
      _crossAxisExtent = value;
      markNeedsLayout();
    }
  }

  Color? get color => _color;
  Color? _color;
  set color(Color? value) {
    if (_color != value) {
      _color = value;
      markNeedsPaint();
    }
  }

  Axis? get fallbackDirection => _fallbackDirection;
  Axis? _fallbackDirection;
  set fallbackDirection(Axis? value) {
    if (_fallbackDirection != value) {
      _fallbackDirection = value;
      markNeedsLayout();
    }
  }

  Axis? get _direction {
    final parentNode = parent;
    if (parentNode is RenderFlex) {
      return parentNode.direction;
    }
    return fallbackDirection;
  }

  double _resolveMain(BoxConstraints constraints, Axis direction) {
    final double maxAvailable = direction == Axis.horizontal
        ? constraints.maxWidth
        : constraints.maxHeight;
    if (!maxAvailable.isFinite) {
      return maxExtent ?? minExtent;
    }
    final double upper = maxExtent ?? maxAvailable;
    return maxAvailable.clamp(minExtent, upper);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final Axis? direction = _direction;
    if (direction == Axis.horizontal) return minExtent;
    return crossAxisExtent?.isFinite == true ? crossAxisExtent! : 0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final Axis? direction = _direction;
    if (direction == Axis.horizontal) return maxExtent ?? minExtent;
    return crossAxisExtent?.isFinite == true ? crossAxisExtent! : 0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final Axis? direction = _direction;
    if (direction == Axis.vertical) return minExtent;
    return crossAxisExtent?.isFinite == true ? crossAxisExtent! : 0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final Axis? direction = _direction;
    if (direction == Axis.vertical) return maxExtent ?? minExtent;
    return crossAxisExtent?.isFinite == true ? crossAxisExtent! : 0;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final Axis? direction = _direction;
    if (direction == null) {
      throw FlutterError(
        'A SpaceMin widget must be placed inside a Flex widget '
        '(Row, Column, or Flex) or a Scrollable.',
      );
    }

    final double main = _resolveMain(constraints, direction);
    final double cross = crossAxisExtent ?? 0;

    if (direction == Axis.horizontal) {
      return constraints.constrain(Size(main, cross));
    }
    return constraints.constrain(Size(cross, main));
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (color != null) {
      final Paint paint = Paint()..color = color!;
      context.canvas.drawRect(offset & size, paint);
    }
  }
}
