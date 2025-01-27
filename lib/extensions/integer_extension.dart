import 'package:flutter_helper_kit/flutter_helper_kit.dart';

/// int Extensions
extension IntNullableExtensions on int? {
  /// Validate given int is not null and returns given value if null.
  int validate([int value = 0]) => this ?? value;

  /// Checks if the given String [s] is null or empty
  bool isNull() => this == null;

  /// Returns microseconds duration
  /// 5.microseconds
  Duration microseconds([int value = 0]) => validate(value).milliseconds();

  /// Returns milliseconds duration
  /// ```dart
  /// 5.milliseconds
  /// ```
  Duration milliseconds([int value = 0]) => validate(value).milliseconds();

  /// Returns seconds duration
  /// ```dart
  /// 5.seconds
  /// ```
  Duration seconds([int value = 0]) => validate(value).seconds();

  /// Returns minutes duration
  /// ```dart
  /// 5.minutes
  /// ```
  Duration minutes([int value = 0]) => validate(value).minutes();

  /// Returns hours duration
  /// ```dart
  /// 5.hours
  /// ```
  Duration hours([int value = 0]) => validate(value).hours();

  /// Returns days duration
  /// ```dart
  /// 5.days
  /// ```
  Duration days([int value = 0]) => validate(value).days();

  /// Returns month duration
  /// ```dart
  /// 5.weeks
  /// ```
  Duration weeks([int value = 0]) => validate(value).weeks();

  /// Returns month duration
  /// ```dart
  /// 5.months
  /// ```
  Duration month([int value = 0]) => validate(value).month();

  /// Returns years duration
  /// ```dart
  /// 5.years
  /// ```
  Duration years([int value = 0]) => validate(value).years();

  /// Returns true if the value is `1`
  /// otherwise false is returned.
  bool toBool([int value = 1]) => validate().toBool(value);

  /// Validate given int is not null and returns given value if null.
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

  /// get last charts of give value
  /// 'I  like dart language'.lastChars(13) // dart language
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
  /// Returns microseconds duration
  /// 5.microseconds
  Duration microseconds() => Duration(microseconds: this);

  /// Returns milliseconds duration
  /// ```dart
  /// 5.milliseconds
  /// ```
  Duration milliseconds() => Duration(milliseconds: this);

  /// Returns seconds duration
  /// ```dart
  /// 5.seconds
  /// ```
  Duration seconds() => Duration(seconds: this);

  /// Returns minutes duration
  /// ```dart
  /// 5.minutes
  /// ```
  Duration minutes() => Duration(minutes: this);

  /// Returns hours duration
  /// ```dart
  /// 5.hours
  /// ```
  Duration hours() => Duration(hours: this);

  /// Returns days duration
  /// ```dart
  /// 5.days
  /// ```
  Duration days() => Duration(days: this);

  /// Returns month duration
  /// ```dart
  /// 5.weeks
  /// ```
  Duration weeks() => Duration(days: this * 7);

  /// Returns month duration
  /// ```dart
  /// 5.months
  /// ```
  Duration month() => Duration(days: (this * 30));

  /// Returns years duration
  /// ```dart
  /// 5.years
  /// ```
  Duration years() => Duration(days: (this * 365));

  /// Returns true if the value is `1`
  /// otherwise false is returned.
  bool toBool([int value = 1]) => this == value ? true : false;

  /// Validate given int is not null and returns given value if null.
  int validate({int value = 0}) => this;

  /// get last charts of give value
  /// 'I  like dart language'.lastChars(13) // dart language
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

  /// returns month name from the given int value between [1-12]
  String toMonthName({bool isHalfName = false}) {
    assert(this >= 1 && this <= 12);
    String status = 'Invalid month of year';
    if (!(this >= 1 && this <= 12)) {
      throw Exception(status);
    }
    return switch (this) {
      (DateTime.january) => isHalfName ? 'Jan' : 'January',
      (DateTime.february) => isHalfName ? 'Feb' : 'February',
      (DateTime.march) => isHalfName ? 'Mar' : 'March',
      (DateTime.april) => isHalfName ? 'Apr' : 'April',
      (DateTime.may) => isHalfName ? 'May' : 'May',
      (DateTime.june) => isHalfName ? 'Jun' : 'June',
      (DateTime.july) => isHalfName ? 'Jul' : 'July',
      (DateTime.august) => isHalfName ? 'Aug' : 'August',
      (DateTime.september) => isHalfName ? 'Sept' : 'September',
      (DateTime.october) => isHalfName ? 'Oct' : 'October',
      (DateTime.november) => isHalfName ? 'Nov' : 'November',
      (DateTime.december) => isHalfName ? 'Dec' : 'December',
      (_) => '',
    };
  }

  /// returns WeekDay from the given int value [1-7]
  String toWeekDay({bool isHalfName = false}) {
    assert(this >= 1 && this <= 7);
    return switch (this) {
      (DateTime.monday) => isHalfName ? 'Mon' : 'Monday',
      (DateTime.tuesday) => isHalfName ? 'Tue' : 'Tuesday',
      (DateTime.wednesday) => isHalfName ? 'Wed' : 'Wednesday',
      (DateTime.thursday) => isHalfName ? 'Thu' : 'Thursday',
      (DateTime.friday) => isHalfName ? 'Fri' : 'Friday',
      (DateTime.saturday) => isHalfName ? 'Sat' : 'Saturday',
      (DateTime.sunday) => isHalfName ? 'Sun' : 'Sunday',
      (_) => '',
    };
  }

  /// Converts the integer to words (supports up to 999,999,999,999)
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

    int absNum = this.abs(); // Handle negative numbers
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

  /// Converts the integer to Roman numerals
  /// Supports numbers from 1 to 3999
  /// Extension to convert integers to Roman numerals
  /// Converts the integer to Roman numerals
  /// Supports numbers from 1 to 3999
  String toRoman() {
    if (this < 1) {
      return '';
    }
    if (this > 3999) {
      throw RangeError.range(
          this, 1, 3999, 'toRoman', 'Value must be between 1 and 3999');
    }

    // Roman numeral mapping in descending order
    const romanNumerals = <int, String>{
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
      1: 'I',
    };

    var number = this;
    final result = StringBuffer();

    // Convert the number to Roman numerals
    for (final entry in romanNumerals.entries) {
      final value = entry.key;
      final numeral = entry.value;

      // Append the numeral while reducing the number
      final count = number ~/ value;
      if (count > 0) {
        result.write(numeral * count);
        number %= value;
      }
    }

    return result.toString();
  }

  /// Converts an [int] into an ordinal number as a [String].
  String toOrdinal([String space = '']) {
    // Handle special case for numbers between 11 and 13, which all use 'th' suffix
    if (this >= 11 && this <= 13) {
      return '${this}${space}th';
    }

    final onesPlace = this % 10;

    switch (onesPlace) {
      case 1:
        return '${this}${space}st';
      case 2:
        return '${this}${space}nd';
      case 3:
        return '${this}${space}rd';
      default:
        return '${this}${space}th';
    }
  }
}
