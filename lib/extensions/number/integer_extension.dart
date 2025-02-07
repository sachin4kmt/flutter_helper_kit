import 'package:flutter_helper_kit/flutter_helper_kit.dart';

/// int Extensions
extension IntNullableExtensions on int? {
  /// Validates the given integer and returns the provided default value if null.
  ///
  /// ```dart
  /// int? number;
  /// print(number.validate()); // Output: 0
  /// print(number.validate(5)); // Output: 5
  /// ```
  int validate([int value = 0]) => this ?? value;

  /// Checks if the given integer is null.
  ///
  /// ```dart
  /// int? number;
  /// print(number.isNull()); // Output: true
  /// number = 5;
  /// print(number.isNull()); // Output: false
  /// ```
  bool isNull() => this == null;

  /// Returns a duration in microseconds.
  ///
  /// ```dart
  /// print(5.microseconds()); // Output: 0:00:00.000005
  /// ```
  Duration microseconds([int value = 0]) => validate(value).milliseconds();

  /// Returns a duration in milliseconds.
  ///
  /// ```dart
  /// print(5.milliseconds()); // Output: 0:00:00.005000
  /// ```
  Duration milliseconds([int value = 0]) => validate(value).milliseconds();

  /// Returns a duration in seconds.
  ///
  /// ```dart
  /// print(5.seconds()); // Output: 0:00:05.000000
  /// ```
  Duration seconds([int value = 0]) => validate(value).seconds();

  /// Returns minutes duration
  /// ```dart
  /// 5.minutes
  /// ```
  Duration minutes([int value = 0]) => validate(value).minutes();

  /// Returns a duration in hours.
  ///
  /// ```dart
  /// print(5.hours()); // Output: 5:00:00.000000
  /// ```
  Duration hours([int value = 0]) => validate(value).hours();

  /// Returns a duration in days.
  ///
  /// ```dart
  /// print(5.days()); // Output: 120:00:00.000000
  /// ```
  Duration days([int value = 0]) => validate(value).days();

  /// Returns a duration in weeks (7 days per week).
  ///
  /// ```dart
  /// print(2.weeks()); // Output: 336:00:00.000000
  /// ```
  Duration weeks([int value = 0]) => validate(value).weeks();

  /// Returns a duration in months (assuming 30 days per month).
  ///
  /// ```dart
  /// print(2.months()); // Output: 1440:00:00.000000
  /// ```
  Duration months([int value = 0]) => validate(value).months();

  /// Returns a duration in years (assuming 365 days per year).
  ///
  /// ```dart
  /// print(1.years()); // Output: 8760:00:00.000000
  /// ```
  Duration years([int value = 0]) => validate(value).years();

  /// Converts the integer to a boolean, where `1` is `true` and all other values are `false`.
  ///
  /// ```dart
  /// print(1.toBool()); // Output: true
  /// print(0.toBool()); // Output: false
  /// ```
  bool toBool([int value = 1]) => validate().toBool(value);

  /// Adds a zero prefix to a single-digit number.
  ///
  /// ```dart
  /// print(5.addZeroPrefix()); // Output: "05"
  /// print(10.addZeroPrefix()); // Output: "10"
  /// ```
  String? addZeroPrefix() {
    if (isNull()) {
      return null;
    }
    if ((this ?? 0) < 10) {
      return '0$this';
    } else {
      return toString();
    }
  }

  /// Gets the last `n` digits of the number.
  ///
  /// ```dart
  /// print(123456789.lastDigits(3)); // Output: 789
  /// print(45.lastDigits(5)); // Output: 45
  /// ```
  int lastDigits(int n) {
    if (isNull()) return 0;
    int charCount = n;
    if (toString().trim().length < n) {
      charCount = toString().trim().length;
    }
    return (toString().trim().substring(toString().trim().length - charCount))
            .toInt() ??
        0;
  }
}

extension IntExtensions on int {
  /// Returns a [Duration] representing microseconds.
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 5.microseconds();
  /// print(duration); // 0:00:00.000005
  /// ```
  Duration microseconds() => Duration(microseconds: this);

  /// Returns a [Duration] representing milliseconds.
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 5.milliseconds();
  /// print(duration); // 0:00:00.005000
  /// ```
  Duration milliseconds() => Duration(milliseconds: this);

  /// Returns a [Duration] representing seconds.
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 5.seconds();
  /// print(duration); // 0:00:05.000000
  /// ```
  Duration seconds() => Duration(seconds: this);

  /// Returns a [Duration] representing minutes.
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 5.minutes();
  /// print(duration); // 0:05:00.000000
  /// ```
  Duration minutes() => Duration(minutes: this);

  /// Returns a [Duration] representing hours.
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 5.hours();
  /// print(duration); // 5:00:00.000000
  /// ```
  Duration hours() => Duration(hours: this);

  /// Returns a [Duration] representing days.
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 5.days();
  /// print(duration); // 120:00:00.000000
  /// ```
  Duration days() => Duration(days: this);

  /// Returns a [Duration] representing weeks.
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 5.weeks();
  /// print(duration); // 35 days, 0:00:00.000000
  /// ```
  Duration weeks() => Duration(days: this * 7);

  /// Returns a [Duration] approximating months (30 days per month).
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 5.months();
  /// print(duration); // 150 days, 0:00:00.000000
  /// ```
  Duration months() => Duration(days: this * 30);

  /// Returns a [Duration] approximating years (365 days per year).
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 5.years();
  /// print(duration); // 1825 days, 0:00:00.000000
  /// ```
  Duration years() => Duration(days: this * 365);

  /// Converts the integer to a boolean.
  ///
  /// Returns `true` if the value matches the given [value], otherwise `false`.
  ///
  /// Example:
  /// ```dart
  /// print(1.toBool()); // true
  /// print(0.toBool()); // false
  /// print(5.toBool(5)); // true
  /// ```
  bool toBool([int value = 1]) => this == value;

  /// Validates the integer and returns the default [value] if it is null.
  ///
  /// Example:
  /// ```dart
  /// int? num;
  /// print(num.validate(value: 10)); // 10
  /// ```
  int validate({int value = 0}) => this;

  /// Retrieves the last `n` digits of the integer.
  ///
  /// Example:
  /// ```dart
  /// print(123456.lastDigits(3)); // 456
  /// ```
  int lastDigits(int n) {
    if (isNull()) return 0;
    int charCount = n;
    if (toString().trim().length < n) {
      charCount = toString().trim().length;
    }
    return (toString().trim().substring(toString().trim().length - charCount))
            .toInt() ??
        0;
  }

  /// Converts the integer to words (supports up to 999,999,999,999).
  ///
  /// Example:
  /// ```dart
  /// print(123.toWords()); // one hundred and twenty-three
  /// ```
  String toWords() {
    if (this == 0) return 'zero';

    final units = [
      '',
      'one',
      'two',
      'three',
      'four',
      'five',
      'six',
      'seven',
      'eight',
      'nine',
      'ten',
      'eleven',
      'twelve',
      'thirteen',
      'fourteen',
      'fifteen',
      'sixteen',
      'seventeen',
      'eighteen',
      'nineteen',
    ];
    final tens = [
      '',
      '',
      'twenty',
      'thirty',
      'forty',
      'fifty',
      'sixty',
      'seventy',
      'eighty',
      'ninety',
    ];
    final scales = ['', 'thousand', 'million', 'billion'];

    String convertLessThanThousand(int num) {
      if (num == 0) return '';

      if (num < 20) return units[num];

      if (num < 100) {
        return tens[num ~/ 10] + (num % 10 != 0 ? '-${units[num % 10]}' : '');
      }

      return '${units[num ~/ 100]} hundred'
          '${num % 100 != 0 ? ' and ${convertLessThanThousand(num % 100)}' : ''}';
    }

    int absNum = abs(); // Handle negative numbers
    String result = '';
    int scaleIndex = 0;

    while (absNum > 0) {
      int chunk = absNum % 1000;
      if (chunk > 0) {
        String chunkWords = convertLessThanThousand(chunk);
        if (scaleIndex > 0 && chunkWords.isNotEmpty) {
          chunkWords += ' ${scales[scaleIndex]}';
        }
        result = '$chunkWords ${result.trim()}';
      }
      absNum ~/= 1000;
      scaleIndex++;
    }

    return (this < 0 ? 'negative ' : '') + result.trim();
  }

  /// Converts the integer to Roman numerals (supports values from 1 to 3999).
  ///
  /// Example:
  /// ```dart
  /// print(2023.toRoman()); // MMXXIII
  /// ```
  String toRoman() {
    if (this < 1 || this > 3999) {
      throw RangeError.range(
          this, 1, 3999, 'toRoman', 'Value must be between 1 and 3999');
    }
    const romanNumerals = {
      1000: 'M',
      900: 'CM',
      500: 'D',
      400: 'CD',
      100: 'C',
      90: 'XC',
      50: 'L',
      40: 'XL',
      10: 'X',
      9: 'IX',
      5: 'V',
      4: 'IV',
      1: 'I'
    };
    var number = this;
    final result = StringBuffer();
    for (final entry in romanNumerals.entries) {
      final count = number ~/ entry.key;
      if (count > 0) {
        result.write(entry.value * count);
        number %= entry.key;
      }
    }
    return result.toString();
  }

  /// Converts an integer to an ordinal representation (e.g., 1st, 2nd, 3rd).
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinal()); // 1st
  /// print(22.toOrdinal()); // 22nd
  /// ```
  String toOrdinal([String space = '']) {
    // Handle special case for numbers between 11 and 13, which all use 'th' suffix
    if (this >= 11 && this <= 13) {
      return '$this${space}th';
    }

    final onesPlace = this % 10;

    switch (onesPlace) {
      case 1:
        return '$this${space}st';
      case 2:
        return '$this${space}nd';
      case 3:
        return '$this${space}rd';
      default:
        return '$this${space}th';
    }
  }
}
