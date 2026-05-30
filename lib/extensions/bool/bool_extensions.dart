/// Utility extensions for working with nullable and non-nullable boolean values.
///
/// These extensions provide a consistent API for:
/// - Null-safe boolean validation.
/// - Boolean state checks.
/// - Integer conversion.
/// - Boolean toggling.
///
/// The nullable extension delegates most operations to the non-nullable
/// extension after resolving a null value through [validate()], ensuring
/// consistent behavior across both implementations.
library;

/// Extensions for nullable [bool] values.
extension BooleanOrNullExtensions on bool? {
  /// Returns the current value if it is not null; otherwise returns [value].
  ///
  /// This method acts as the foundation for all nullable boolean operations.
  ///
  /// Example:
  /// `dart
  /// bool? flag = null;
  ///
  /// flag.validate(); // false
  /// flag.validate(value: true); // true
  /// `
  bool validate({bool value = false}) => this ?? value;

  /// Returns `true` when the value is `true`.
  ///
  /// A `null` value is treated as `false`.
  ///
  /// Example:
  /// `dart
  /// bool? flag = true;
  /// flag.isTrue(); // true
  /// `
  bool isTrue() => validate().isTrue();

  /// Returns `true` when the value is `false`.
  ///
  /// A `null` value is treated as `false`.
  ///
  /// Example:
  /// `dart
  /// bool? flag = false;
  /// flag.isFalse(); // true
  /// `
  bool isFalse() => validate().isFalse();

  /// Returns `true` when the value is not `true`.
  ///
  /// A `null` value is treated as `false`.
  ///
  /// Example:
  /// `dart
  /// bool? flag = null;
  /// flag.isNotTrue(); // true
  /// `
  bool isNotTrue() => validate().isNotTrue();

  /// Returns `true` when the value is not `false`.
  ///
  /// A `null` value is treated as `false`.
  ///
  /// Example:
  /// `dart
  /// bool? flag = true;
  /// flag.isNotFalse(); // true
  /// `
  bool isNotFalse() => validate().isNotFalse();

  /// Converts the boolean value to an integer.
  ///
  /// Returns:
  /// - `1` for `true`
  /// - `0` for `false` or `null`
  ///
  /// Example:
  /// `dart
  /// bool? flag = true;
  /// flag.toInt(); // 1
  /// `
  int toInt() => validate().toInt();

  /// Returns the opposite boolean value.
  ///
  /// Behavior:
  /// - `true` → `false`
  /// - `false` → `true`
  /// - `null` → `true`
  ///
  /// Example:
  /// `dart
  /// bool? flag = null;
  /// flag.toggle(); // true
  /// `
  bool toggle() => validate().toggle();
}

/// Extensions for non-nullable [bool] values.
extension BooleanExtensions on bool {
  /// Returns whether this value is `true`.
  ///
  /// Example:
  /// `dart
  /// true.isTrue(); // true
  /// `
  bool isTrue() => this;

  /// Returns whether this value is `false`.
  ///
  /// Example:
  /// `dart
  /// false.isFalse(); // true
  /// `
  bool isFalse() => !this;

  /// Returns whether this value is not `true`.
  ///
  /// Example:
  /// `dart
  /// false.isNotTrue(); // true
  /// `
  bool isNotTrue() => !this;

  /// Returns whether this value is not `false`.
  ///
  /// Example:
  /// `dart
  /// true.isNotFalse(); // true
  /// `
  bool isNotFalse() => this;

  /// Converts the boolean value to an integer.
  ///
  /// Returns:
  /// - `1` for `true`
  /// - `0` for `false`
  ///
  /// Example:
  /// `dart
  /// true.toInt(); // 1
  /// `
  int toInt() => this ? 1 : 0;

  /// Returns the opposite boolean value.
  ///
  /// Example:
  /// `dart
  /// true.toggle(); // false
  /// false.toggle(); // true
  /// `
  bool toggle() => !this;
}
