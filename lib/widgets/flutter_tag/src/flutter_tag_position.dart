class FlutterTagPosition {
  /// Distance to the top side of the parent widget.
  final double? top;

  /// Distance to the end side of the parent widget.
  final double? end;

  /// Distance to the start side of the parent widget.
  final double? start;

  /// Distance to the bottom side of the parent widget.
  final double? bottom;

  /// Indicates if the badge should be centered within the parent widget.
  final bool isCenter;
  const FlutterTagPosition._({
    this.top,
    this.end,
    this.bottom,
    this.start,
    this.isCenter = false,
  }) : super();

  /// Factory method that creates a new instance of this widget
  /// according to the center
  factory FlutterTagPosition.center() {
    return const FlutterTagPosition._(isCenter: true);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [top] and [start]
  factory FlutterTagPosition.topStart({double top = -5, double start = -10}) {
    return FlutterTagPosition._(top: top, start: start);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [top] and [end]
  factory FlutterTagPosition.topEnd({double top = -8, double end = -10}) {
    return FlutterTagPosition._(top: top, end: end);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [bottom] and [end]
  factory FlutterTagPosition.bottomEnd({double bottom = -8, double end = -10}) {
    return FlutterTagPosition._(bottom: bottom, end: end);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [bottom] and [start]
  factory FlutterTagPosition.bottomStart(
      {double bottom = -8, double start = -10}) {
    return FlutterTagPosition._(bottom: bottom, start: start);
  }

  factory FlutterTagPosition.custom({
    double? start,
    double? end,
    double? top,
    double? bottom,
    bool isCenter = false,
  }) {
    return FlutterTagPosition._(
        top: top, end: end, bottom: bottom, start: start, isCenter: isCenter);
  }
}
