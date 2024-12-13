/// Duration Extensions
extension DurationExtension on Duration {
  /// Delays execution for the specified duration.
  ///
  /// Returns a [Future] that completes after the specified [Duration].
  ///
  /// Example usage:
  /// ```dart
  /// await Duration(seconds: 1).delay();
  /// ```
  Future<void> delay() => Future.delayed(this);
}
