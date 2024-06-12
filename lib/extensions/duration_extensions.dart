part of flutter_helper_kit;


// Duration Extensions
extension GetDurationUtils on Duration {
  /// Delays execution for the specified duration.
  ///
  /// Returns a [Future] that completes after the specified [Duration].
  ///
  /// Example usage:
  /// ```dart
  /// await Duration(seconds: 1).delay();
  /// ```
  Future<void> get delay => Future.delayed(this);
}