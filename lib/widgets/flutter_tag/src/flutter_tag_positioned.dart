import 'package:flutter/widgets.dart';

import 'flutter_tag_position.dart';

/// A widget that positions a child widget within a parent widget using
/// the provided [FlutterTagPositionBase] parameters.
///
/// The [position] parameter determines where the badge should be placed
/// relative to its parent widget. If [position] is null, it defaults to
/// `FlutterTagPosition.topEnd()`. The [child] parameter is the widget
/// that will be positioned according to the given parameters.
class FlutterTagPositioned extends StatelessWidget {
  /// The position of the badge relative to the parent widget.
  /// If null, defaults to `FlutterTagPosition.topEnd()`.
  final FlutterTagPosition? position;

  /// The child widget to be positioned.
  final Widget child;

  /// Creates a [FlutterTagPositioned] widget.
  ///
  /// [key] is used to identify this widget in the widget tree.
  /// [position] determines the badge's position relative to its parent.
  /// [child] is the widget to be positioned according to the [position].
  const FlutterTagPositioned({
    super.key,
    this.position,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    /// Use the provided position or default to top-end position.
    final pos = position ?? FlutterTagPosition.topEnd();

    /// If the position indicates the badge should be centered, use Positioned.fill
    if (pos.isCenter) {
      return Positioned.fill(
        /// Center the child widget within the parent widget.
        child: Center(child: child),
      );
    }

    /// Use PositionedDirectional to apply the position offsets.
    return PositionedDirectional(
      /// Apply positional offsets, using default values if not provided.
      top: pos.top,
      end: pos.end,
      bottom: pos.bottom,
      start: pos.start,
      child: child,
    );
  }
}
