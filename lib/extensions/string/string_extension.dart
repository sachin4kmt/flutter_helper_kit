import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

extension NullStringExtension on String? {
  /// Checks if the given [String] is not null or empty.
  ///
  /// Example:
  /// ```dart
  /// String? value = "Hello";
  /// print(value.isNotEmptyOrNull); // true
  /// ```
  bool get isNotEmptyOrNull => !isEmptyOrNull;

  /// Checks if the given [String] is null or empty.
  ///
  /// Example:
  /// ```dart
  /// String? value = null;
  /// print(value.isEmptyOrNull); // true
  /// ```
  bool get isEmptyOrNull =>
      this == null ||
      (this != null && this!.isEmpty) ||
      (this != null && this! == 'null');

  /// Returns the [String] if it's not null, otherwise returns the provided default value.
  ///
  /// Example:
  /// ```dart
  /// String? name = null;
  /// print(name.validate("Default")); // "Default"
  /// ```
  String validate([String value = '']) =>
      this?.trim().isEmptyOrNull ?? true ? value : this!;

  /// Returns an empty [String] if null.
  ///
  /// Example:
  /// ```dart
  /// String? text = null;
  /// print(text.defaultBlank()); // ""
  /// ```
  String defaultBlank() => isEmptyOrNull ? '' : this!;

  /// Checks if the [String] is an [integer].
  ///
  /// Example:
  /// ```dart
  /// print("123".isInt()); // true
  /// print("abc".isInt()); // false
  /// ```
  bool isInt() => isEmptyOrNull ? false : int.tryParse(this!) != null;

  /// Converts the [String] to an [integer].
  ///
  /// Example:
  /// ```dart
  /// print("123".toInt()); // 123
  /// ```
  int? toInt() => isNotEmptyOrNull ? int.tryParse(this!) : null;

  /// Checks if the [String] is an [Number].
  ///
  /// Example:
  /// ```dart
  /// print("123".isNum()); // true
  /// print("abc".isNum()); // false
  /// ```
  bool isNum() => isEmptyOrNull ? false : num.tryParse(this!) != null;

  /// Converts the [String] to an [Number].
  ///
  /// Example:
  /// ```dart
  /// print("123".toNum()); // 123
  /// ```
  num? toNum() => isNotEmptyOrNull ? num.tryParse(this!) : null;

  /// Checks if the [String] value is convertible to [DateTime].
  ///
  /// Returns [true] if the string can be parsed as a valid DateTime.
  /// Otherwise, returns [false].
  ///
  /// Example:
  /// ```dart
  /// String? dateStr = "2023-04-28T05:34:53.684Z";
  /// print(dateStr.isDateTime()); // true
  /// String? invalidDateStr = "not_a_date";
  /// print(invalidDateStr.isDateTime()); // false
  /// ```
  bool isDateTime() =>
      isNotEmptyOrNull ? DateTime.tryParse(this!) != null : false;

  /// Converts the [String] value to a [DateTime] object if it's valid.
  ///
  /// Returns the [DateTime] object if the string can be parsed successfully,
  /// otherwise returns `null`.
  ///
  /// Example:
  /// ```dart
  /// String? dateStr = "2023-04-28T05:34:53.684Z";
  /// print(dateStr.toDateTime()); // 2023-04-28 05:34:53.684Z
  /// ```
  DateTime? toDateTime() => isNotEmptyOrNull ? DateTime.tryParse(this!) : null;

  /// Checks if the [String] value is convertible to a [double].
  ///
  /// Returns [true] if the string can be parsed as a valid double.
  /// Otherwise, returns [false].
  ///
  /// Example:
  /// ```dart
  /// String? numberStr = "123.45";
  /// print(numberStr.isDouble()); // true
  /// String? invalidNumberStr = "abc";
  /// print(invalidNumberStr.isDouble()); // false
  /// ```
  bool isDouble() => isEmptyOrNull ? false : double.tryParse(this!) != null;

  /// Converts the [String] value to a [double] if it's valid.
  ///
  /// Returns the [double] value if the string can be parsed successfully,
  /// otherwise returns `null`.
  ///
  /// Example:
  /// ```dart
  /// String? numberStr = "123.45";
  /// print(numberStr.toDouble()); // 123.45
  /// ```
  double? toDouble() => isNotEmptyOrNull ? double.tryParse(this!) : null;

  /// Returns the length of the [String] after trimming leading and trailing whitespace.
  ///
  /// Example:
  /// ```dart
  /// String? text = " Hello ";
  /// print(text.length); // 5
  /// String? emptyText = "";
  /// print(emptyText.length); // 0
  /// ```
  int get length => validate().length;

  /// Checks whether the given string contains a single letter or not and return [True] if contains otherwise return [False]
  bool isContainsAlphabetLetter() {
    if (isEmptyOrNull) return false;
    RegExp isLetterRegExp = RegExp(r'[A-Za-z]', caseSensitive: false);
    return isLetterRegExp.hasMatch(this!);
  }

  /// Returns `true` if string contains only alphabet symbols
  bool isAlphabetOnly() =>
      !isEmptyOrNull ? RegExp(r'^[a-zA-Z]+$').hasMatch(this!) : false;

  /// Removes all white spaces from the string.
  ///
  /// Example:
  /// ```dart
  /// print("Hello World".removeAllWhiteSpace()); // "HelloWorld"
  /// ```
  String removeAllWhiteSpace() =>
      !isEmptyOrNull ? this!.replaceAll(RegExp(r'\s+\b|\b\s'), '') : '';

  /// Returns the reversed string.
  ///
  /// Example:
  /// ```dart
  /// print("hello".reversed()); // "olleh"
  /// ```
  String reversed() =>
      !isEmptyOrNull ? String.fromCharCodes(this!.codeUnits.reversed) : '';

  /// Checks if the [String] starts with the given [characters], with an optional case sensitivity.
  ///
  /// Returns [true] if the string starts with the specified [characters], otherwise returns [false].
  /// The comparison can be case-sensitive or case-insensitive, depending on the [matchCase] parameter.
  ///
  /// Example:
  /// ```dart
  /// String? text = "Hello World";
  /// print(text.startsWithCharacters("Hello")); // true
  /// print(text.startsWithCharacters("hello", matchCase: true)); // false
  /// print(text.startsWithCharacters("hello", matchCase: false)); // true
  /// ```
  bool startsWithCharacters(String characters, {bool matchCase = false}) {
    if (characters.isEmpty || isEmptyOrNull) {
      return false;
    }
    if (matchCase) {
      return this!.startsWith(characters);
    }
    return this!.toLowerCase().startsWith(characters.toLowerCase());
  }

  /// Validates whether the [String] is a valid URL.
  ///
  /// This method uses a regular expression defined in [RegExpPatterns.url] to check if the string matches a valid URL format.
  ///
  /// Returns [true] if the string is a valid URL, otherwise returns [false].
  ///
  /// Example:
  /// ```dart
  /// String? url = "https://www.example.com";
  /// print(url.validateURL()); // true
  ///
  /// String? invalidUrl = "invalid-url";
  /// print(invalidUrl.validateURL()); // false
  /// ```
  bool validateURL() => hasMatch(this, RegExpPatterns.url);

  /// Capitalizes the first letter of the string.
  ///
  /// Example:
  /// ```dart
  /// print("hello".capitalizeFirstCharacter()); // "Hello"
  /// ```
  String capitalizeFirstCharacter() =>
      !isEmptyOrNull ? '${this![0].toUpperCase()}${this!.substring(1)}' : '';

  /// Capitalizes the first letter of each word in the string.
  ///
  /// Example:
  /// ```dart
  /// print("hello world".capitalizeEachWordFirstCharacter()); // "Hello World"
  /// ```
  String capitalizeEachWordFirstCharacter() {
    if (isEmptyOrNull) return '';
    final words = this!.split(' ');
    final formatted = words.map((e) => e.capitalizeFirstCharacter).toList();
    return formatted.join(' ');
  }

  /// Returns the last [n] characters of the string.
  ///
  /// If the string length is shorter than [n], it returns the entire string.
  /// The string is also trimmed before extracting the last [n] characters.
  ///
  /// Example:
  /// ```dart
  /// String? text = "Hello World";
  /// print(text.lastChars(5)); // "World"
  /// print(text.lastChars(10)); // "Hello World"
  /// print(text.lastChars(15)); // "Hello World"
  /// ```
  String lastChars(int n) {
    if (isEmptyOrNull) return '';
    int charCount = n;
    if (this!.length < n) {
      charCount = this!.length;
    }
    return this!.trim().substring(this!.length - charCount);
  }

  /// Checks if the string is a valid JSON.
  ///
  /// Example:
  /// ```dart
  /// print('{"name": "Flutter"}'.isJsonDecodable()); // true
  /// print("Hello".isJsonDecodable()); // false
  /// ```
  bool isJsonDecodable() {
    if (isEmptyOrNull) return false;
    try {
      jsonDecode(this!) as Map<String, dynamic>;
    } on FormatException {
      return false;
    }
    return true;
  }

  /// Returns the first [numberOfCharacters] from the first letter of each word in the string.
  ///
  /// The string is split into words based on the provided [splitBy] pattern (default is whitespace).
  /// The result contains the first letter of each word, up to the specified [numberOfCharacters].
  /// If [numberOfCharacters] is not provided, it includes the first letter of each word in the string.
  ///
  /// Example:
  /// ```dart
  /// String? text = "Hello Flutter Developer";
  /// print(text.toWordsFirstCharacters(numberOfCharacters: 2)); // "HF"
  /// print(text.toWordsFirstCharacters()); // "HFD"
  ///
  /// String? emptyText = "";
  /// print(emptyText.toWordsFirstCharacters()); // ""
  /// ```
  String toWordsFirstCharacters(
      {int? numberOfCharacters, String splitBy = '\\s+'}) {
    var initials = '';
    if (validate().isEmptyOrNull) {
      return '';
    }
    final nameParts = this!.trim().toUpperCase().split(RegExp(splitBy));
    var num =
        math.min(nameParts.length, numberOfCharacters ?? nameParts.length);
    for (var i = 0; i < num; i++) {
      initials += nameParts[i][0];
    }
    return initials;
  }

  /// Returns only the first [numberOfCharacters] characters of the string.
  ///
  /// Example:
  /// ```dart
  /// print("Flutter".take(3)); // "Flu"
  /// ```
  String take(int numberOfCharacters) {
    if (isEmptyOrNull) return '';
    var num = math.min(this!.characters.length, numberOfCharacters);
    return this!.trim().characters.take(num).join();
  }

  /// Counts the number of words in the string.
  ///
  /// Example:
  /// ```dart
  /// print("Hello Flutter Developer".countWords()); // 3
  /// ```
  int countWords() {
    if (validate().isEmptyOrNull) return 0;
    return this!.split(RegExp('\\s+')).length;
  }
}
