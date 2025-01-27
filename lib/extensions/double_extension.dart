/// Double Extensions
extension DoubleOrNullExtensions on double? {
  /// Checks if the given String [s] is null or empty
  bool isNull() => this == null;

  /// Validates the double value and returns it if not null.
  ///
  /// If the value is null, returns 0.0.
  double validate({double value = 0.0}) => this ?? value;
}
