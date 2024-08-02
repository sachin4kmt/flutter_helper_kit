/// A utility class for formatting numbers in either Indian or International numeral systems.
///
/// This class provides methods to format numbers based on the chosen numeral system.
/// It supports formatting numbers with up to three digits after the decimal point.
///
class Numeral {
  /// The number to be formatted.
  final num number;

  /// The number of digits to display after the decimal point.
  ///
  /// Defaults to 0, which means no digits after the decimal point.
  ///
  /// Must be less than 4.
  final int digitAfterDecimal;

  /// Creates a Numeral instance with the specified [number] and optional [digitAfterDecimal].
  ///
  /// The [digitAfterDecimal] parameter specifies the number of digits to display after the decimal point.
  ///
  /// Throws an AssertionError if [digitAfterDecimal] is not less than 4.
  Numeral(this.number, {this.digitAfterDecimal = 0})
      : assert(digitAfterDecimal < 4);

  /// Formats the number in the Indian numeral system.
  ///
  /// Example:
  /// ```dart
  /// Numeral numeral = Numeral(1234567.89);
  /// String indianFormatted = numeral.indian; // Output: 12.34 L
  /// ```
  String get indian {
    if (number == 0) {
      return '0';
    } else if (number <= 999) {
      return number.toString();
    } else if (number > 999 && number <= 99999) {
      return '${_getNumber((number / 1000))} K';
    } else if (number > 99999 && number <= 9999999) {
      return '${_getNumber((number / 100000))} L';
    } else if (number > 9999999 && number <= 999999999) {
      return '${_getNumber((number / 10000000))} Cr';
    } else {
      return '${_getNumber((number / 1000000000))} Ar';
    }
  }

  /// Formats the number in the International numeral system.
  ///
  /// Example:
  /// ```dart
  /// Numeral numeral = Numeral(1234567.89);
  /// String internationalFormatted = numeral.international; // Output: 1.23 M
  /// ```
  String get international {
    if (number == 0) {
      return '0';
    } else if (number <= 999) {
      return number.toString();
    } else if (number > 999 && number <= 999999) {
      return '${_getNumber((number / 1000))} K';
    } else if (number > 999999 && number <= 999999999) {
      return '${_getNumber((number / 1000000))} M';
    } else if (number > 999999999 && number <= 999999999999) {
      return '${_getNumber((number / 1000000000))} B';
    } else {
      return '${_getNumber((number / 1000000000000))} T';
    }
  }

  String _getNumber(double input) {
    // return "${input.toString().split(".").first}.${input.toStringAsFixed(4).toString().split(".").last.substring(0, digitAfterDecimal == DigitAfterDecimal.one ? 1 : digitAfterDecimal == DigitAfterDecimal.two ? 2 : 3)}";
    if (digitAfterDecimal == 0) {
      return input.toString().split('.').first;
    } else {
      return "${input.toString().split(".").first}.${input.toStringAsFixed(4).toString().split(".").last.substring(0, digitAfterDecimal)}";
    }
  }
}
