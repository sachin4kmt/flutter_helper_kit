/// A collection of boolean extension methods to simplify boolean operations.
///
/// This extension provides convenient methods to perform various operations
/// on boolean values, such as validation, checking for true/false, toggling,
/// and converting to integer values.
///
/// Example usage:
/// ```dart
/// import 'package:flutter_helper_kit/flutter_helper_kit.dart';
///
/// void main() {
///   // Example usage of boolean extensions
///   bool? nullableBool = true;
///
///   // Validate a boolean value and provide a default if null
///   bool validatedValue = nullableBool.validate(value: false);
///   print(validatedValue); // Output: true
///
///   // Check if a boolean value is true
///   print(nullableBool.isTrue); // Output: true
///
///   // Check if a boolean value is false
///   print(nullableBool.isFalse); // Output: false
///
///   // Check if a boolean value is not true
///   print(nullableBool.isNotTrue); // Output: false
///
///   // Check if a boolean value is not false
///   print(nullableBool.isNotFalse); // Output: true
///
///   // Convert a boolean value to an integer (1 if true, 0 if false)
///   int intValue = nullableBool.toInt;
///   print(intValue); // Output: 1
///
///   // Toggle the boolean value
///   bool toggledValue = nullableBool.toggle;
///   print(toggledValue); // Output: false
/// }
/// ```
extension BooleanExtensions on bool? {
  /// Validates the given boolean value.
  ///
  /// If the value is not null, it returns the value itself.
  /// If the value is null, it returns the provided [value].
  bool validate({bool value = false}) => this ?? value;

  /// Checks if the boolean value is true.
  bool get isTrue => this != null && this!;

  /// Checks if the boolean value is false.
  bool get isFalse => this != null && !this!;

  /// Checks if the boolean value is not true.
  bool get isNotTrue => this == null || !this!;

  /// Checks if the boolean value is not false.
  bool get isNotFalse => this == null || this!;

  /// Converts the boolean value to an integer.
  ///
  /// Returns 1 if the value is true, otherwise returns 0.
  int get toInt => this != null && this! ? 1 : 0;

  /// Toggles the boolean value.
  ///
  /// If the value is true, it returns false.
  /// If the value is false or null, it returns true.
  bool get toggle => this != null ? !this! : false;
}