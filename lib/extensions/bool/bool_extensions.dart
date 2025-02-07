extension BooleanOrNullExtensions on bool? {
  /// Validates the given boolean value.
  ///
  /// If the value is not null, it returns the value itself.
  /// If the value is null, it returns the provided [value].
  ///
  /// Example:
  /// ```dart
  /// bool? value = null;
  /// print(value.validate(value: true)); // true
  /// print(value.validate()); // false
  /// ```
  bool validate({bool value = false}) => this ?? value;

  /// Checks if the boolean value is true.
  ///
  /// Returns `true` if the value is true, otherwise returns `false`.
  ///
  /// Example:
  /// ```dart
  /// bool? value = true;
  /// print(value.isTrue()); // true
  /// ```
  bool isTrue() => validate().isTrue();

  /// Checks if the boolean value is false.
  ///
  /// Returns `true` if the value is false, otherwise returns `false`.
  ///
  /// Example:
  /// ```dart
  /// bool? value = false;
  /// print(value.isFalse()); // true
  /// ```
  bool isFalse() => validate().isFalse();

  /// Checks if the boolean value is not true.
  ///
  /// Returns `true` if the value is not true, otherwise returns `false`.
  ///
  /// Example:
  /// ```dart
  /// bool? value = false;
  /// print(value.isNotTrue()); // true
  /// ```
  bool isNotTrue() => validate().isNotTrue();

  /// Checks if the boolean value is not false.
  ///
  /// Returns `true` if the value is not false, otherwise returns `false`.
  ///
  /// Example:
  /// ```dart
  /// bool? value = true;
  /// print(value.isNotFalse()); // true
  /// ```
  bool isNotFalse() => validate().isNotFalse();

  /// Converts the boolean value to an integer.
  ///
  /// Returns 1 if the value is true, otherwise returns 0.
  ///
  /// Example:
  /// ```dart
  /// bool? value = true;
  /// print(value.toInt()); // 1
  /// ```
  int toInt() => validate().toInt();

  /// Toggles the boolean value.
  ///
  /// If the value is true, it returns false.
  /// If the value is false or null, it returns true.
  ///
  /// Example:
  /// ```dart
  /// bool? value = true;
  /// print(value.toggle()); // false
  /// value = null;
  /// print(value.toggle()); // true
  /// ```
  bool toggle() => validate().toggle();
}

extension BooleanExtensions on bool {
  /// Checks if the boolean value is true.
  ///
  /// Returns `true` if the value is true.
  ///
  /// Example:
  /// ```dart
  /// bool value = true;
  /// print(value.isTrue()); // true
  /// ```
  bool isTrue() => this;

  /// Checks if the boolean value is false.
  ///
  /// Returns `true` if the value is false, otherwise returns `false`.
  ///
  /// Example:
  /// ```dart
  /// bool value = false;
  /// print(value.isFalse()); // true
  /// ```
  bool isFalse() => !this;

  /// Checks if the boolean value is not true.
  ///
  /// Returns `true` if the value is not true, otherwise returns `false`.
  ///
  /// Example:
  /// ```dart
  /// bool value = false;
  /// print(value.isNotTrue()); // true
  /// ```
  bool isNotTrue() => !this;

  /// Checks if the boolean value is not false.
  ///
  /// Returns `true` if the value is not false, otherwise returns `false`.
  ///
  /// Example:
  /// ```dart
  /// bool value = true;
  /// print(value.isNotFalse()); // true
  /// ```
  bool isNotFalse() => this;

  /// Converts the boolean value to an integer.
  ///
  /// Returns 1 if the value is true, otherwise returns 0.
  ///
  /// Example:
  /// ```dart
  /// bool value = true;
  /// print(value.toInt()); // 1
  /// ```
  int toInt() => this ? 1 : 0;

  /// Toggles the boolean value.
  ///
  /// If the value is true, it returns false.
  /// If the value is false, it returns true.
  ///
  /// Example:
  /// ```dart
  /// bool value = true;
  /// print(value.toggle()); // false
  /// value = false;
  /// print(value.toggle()); // true
  /// ```
  bool toggle() => !this;
}
