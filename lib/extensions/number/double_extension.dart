/// Extension on `double?` to provide utility methods for validation and null checking.
extension DoubleOrNullExtensions on double? {
  /// Checks if the given double value is `null`.
  ///
  /// Returns `true` if the value is `null`, otherwise `false`.
  ///
  /// ### Example:
  /// ```dart
  /// double? value1;
  /// double? value2 = 5.5;
  ///
  /// print(value1.isNull()); // Output: true
  /// print(value2.isNull()); // Output: false
  /// ```
  bool isNull() => this == null;

  /// Validates the double value and returns it if not null.
  ///
  /// If the value is `null`, returns the specified `value` (default is `0.0`).
  ///
  /// ### Example:
  /// ```dart
  /// double? value1;
  /// double? value2 = 3.14;
  ///
  /// print(value1.validate()); // Output: 0.0
  /// print(value1.validate(value: 1.5)); // Output: 1.5
  /// print(value2.validate()); // Output: 3.14
  /// ```
  double validate({double value = 0.0}) => this ?? value;
}
