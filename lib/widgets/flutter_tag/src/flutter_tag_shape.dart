/// Enum representing the different shapes that can be used for a badge.
///
/// The shapes defined in this enum are used to determine the appearance
/// of badges in the [Badge] widget. Each shape has its own unique
/// visual characteristics and can be customized further using properties
/// such as border radius and color.
enum FlutterTagShape {
  /// Circular shape for badges. This is the default shape.
  ///
  /// A circular badge can be used to create a round badge with a consistent
  /// radius. Ideal for notifications or labels where a round shape is preferred.
  ///
  /// See also:
  /// * [CircleBorder]
  circle,

  /// Square shape for badges.
  ///
  /// A square badge provides a box-like appearance with equal width and height.
  /// It is a straightforward shape that fits well in various UI elements.
  ///
  /// See also:
  /// * [RoundedRectangleBorder]
  square,

  /// Cloud-shaped badge.
  ///
  /// A cloud-shaped badge has a rounded, fluffy outline resembling a cloud.
  /// Useful for creating badges that convey a light, airy feel.
  ///
  /// See also:
  /// * [CustomPainter]
  cloud,

  /// Star-shaped badge.
  ///
  /// A star-shaped badge features a five-pointed star outline. Ideal for
  /// highlighting achievements or special statuses.
  ///
  /// See also:
  /// * [CustomPainter]
  star,

  /// Diamond-shaped badge.
  ///
  /// A diamond-shaped badge provides a diamond-like outline, which is useful
  /// for creating eye-catching or standout badges.
  ///
  /// See also:
  /// * [CustomPainter]
  diamond,

  /// Hexagon-shaped badge.
  ///
  /// A hexagon-shaped badge has a six-sided outline. It can be used to create
  /// badges with a geometric or modern appearance.
  ///
  /// See also:
  /// * [CustomPainter]
  hexagon,

  /// Pentagon-shaped badge.
  ///
  /// A pentagon-shaped badge features a five-sided outline. It is ideal for
  /// creating badges that need a unique geometric shape.
  ///
  /// See also:
  /// * [CustomPainter]
  pentagon,
}
